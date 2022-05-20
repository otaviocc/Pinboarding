import Combine
import Foundation
import MicroClient
import MicroPinboard

protocol NetworkServiceProtocol {

    /// Publishes all bookmarks during recurring
    /// updates.
    func allBookmarksUpdatesPublisher(
    ) -> AnyPublisher<[PostResponse], Never>

    /// Publishes the network status to update the UI
    /// during update requests.
    func networkActivityPublisher(
    ) -> AnyPublisher<NetworkActivityEvent, Never>

    /// Returns all saved bookmark.
    func allBookmarks(
    ) async throws -> [PostResponse]

    /// Adds a new bookmark.
    func addBookmark(
        url: URL,
        description: String,
        extended: String?,
        tags: String?,
        date: Date?,
        replace: String?,
        shared: String?,
        toread: String?
    ) async throws -> PostResponse
}

final class NetworkService: NetworkServiceProtocol {

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()
    private let networkClient: NetworkClientProtocol
    private let settingsStore: SettingsStore
    private let postResponseSubject =
    PassthroughSubject<[PostResponse], Never>()

#if DEBUG
    let refreshInterval = 30.0
#else
    let refreshInterval = 300.0
#endif

    // MARK: - Life cycle

    init(
        settingsStore: SettingsStore,
        networkClient: NetworkClientProtocol
    ) {
        self.settingsStore = settingsStore
        self.networkClient = networkClient

        recentBookmarksPublisher()
            .receive(on: RunLoop.main)
            .flatMap(Just.init)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    self.postResponseSubject.send($0)
                }
            )
            .store(in: &cancellables)
    }

    // MARK: - Public

    func allBookmarksUpdatesPublisher(
    ) -> AnyPublisher<[PostResponse], Never> {
        postResponseSubject
            .eraseToAnyPublisher()
    }

    func networkActivityPublisher(
    ) -> AnyPublisher<NetworkActivityEvent, Never> {
        networkClient.statusPublisher()
            .map { status in
                switch status {
                case .running: return .loading
                case .idle: return .finishedLoading
                }
            }
            .eraseToAnyPublisher()
    }

    func allBookmarks(
    ) async throws -> [PostResponse] {
        guard try await needsBookmarksUpdate() else {
            throw NetworkServiceError.noNeedToSync
        }

        let request = PostsAPIFactory.makeAllRequest()
        let response = try await networkClient.run(request)

        return response.value
    }

    func addBookmark(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: String? = nil,
        shared: String? = nil,
        toread: String? = nil
    ) async throws -> PostResponse {
        _ = try await addNewBookmark(
            url: url,
            description: description,
            extended: extended,
            tags: tags,
            date: date,
            replace: replace,
            shared: shared,
            toread: toread
        )

        return try await lastBookmark()
    }

    // MARK: - Private

    private func timerPublisher(
    ) -> AnyPublisher<Date, Never> {
        Deferred {
            Just(Date())
        }
        .append(
            Timer.TimerPublisher(
                interval: refreshInterval,
                runLoop: .main,
                mode: .common
            )
            .autoconnect()
        )
        .eraseToAnyPublisher()
    }

    /// Publishes all bookmarks every x minutes.
    private func recentBookmarksPublisher(
    ) -> AnyPublisher<[PostResponse], Error> {
        timerPublisher()
            .flatMap { _ in
                Future { promise in
                    Task {
                        do {
                            let allBookmarks = try await self.allBookmarks()
                            promise(.success(allBookmarks))
                        } catch {
                            print("Error fetching recent bookmarks. Reason: \(error)")
                        }
                    }
                }
            }
            .eraseToAnyPublisher()
    }

    /// Returns the latest saved bookmark.
    private func lastBookmark(
    ) async throws -> PostResponse {
        let request = PostsAPIFactory.makeRecentRequest(count: 1)
        let response = try await networkClient.run(request)

        guard let bookmark = response.value.posts.first else {
            throw NetworkServiceError.missingBookmark
        }

        return bookmark
    }

    private func needsBookmarksUpdate(
    ) async throws -> Bool {
        let request = UpdateAPIFactory.makeUpdateRequest()
        let response = try await networkClient.run(request)

        guard settingsStore.lastSyncDate != response.value.updateTime else {
            return false
        }

        settingsStore.lastSyncDate = response.value.updateTime

        return true
    }

    private func addNewBookmark(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: String? = nil,
        shared: String? = nil,
        toread: String? = nil
    ) async throws -> Bool {
        let request = PostsAPIFactory.makeAddRequest(
            url: url,
            description: description,
            extended: extended,
            tags: tags,
            date: date,
            replace: replace,
            shared: shared,
            toread: toread
        )
        let response = try await networkClient.run(request)

        return response.value.resultCode == "done"
    }
}
