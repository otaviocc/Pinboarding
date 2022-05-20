import Combine
import Foundation
import MicroClient
import MicroPinboard

final class NetworkService {

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

    /// Publishes all bookmarks during recurring
    /// updates.
    func allBookmarksUpdatesPublisher(
    ) -> AnyPublisher<[PostResponse], Never> {
        postResponseSubject
            .eraseToAnyPublisher()
    }

    /// Publishes the network status to update the UI
    /// during update requests.
    func networkActivityPublisher(
    ) -> AnyPublisher<NetworkActivityEvent, Never> {
        Just(.finishedLoading).eraseToAnyPublisher()
        //        pinboardAPI.eventPublisher()
        //            .map { event in
        //                switch event {
        //                case .loading:
        //                    return .loading
        //                case .finishedLoading:
        //                    return .finishedLoading
        //                case .errorLoading:
        //                    return .errorLoading
        //                }
        //            }
        //            .eraseToAnyPublisher()
    }

    // MARK: - Private

    /// Publishes every x minutes starting now.
    /// This is used to schedule updates, emitting
    /// the first event right when `sink` is called.
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
                        let allBookmarks = await self.allBookmarks()
                        promise(.success(allBookmarks))
                    }
                }
            }
            .eraseToAnyPublisher()
    }

    /// Returns all saved bookmark.
    func allBookmarks(
    ) async -> [PostResponse] {
        let request = PostsAPIFactory.makeAllRequest()
        let response = try? await networkClient.run(request)

        return response?.value ?? []
    }

    /// Returns the latest saved bookmark.
    private func lastBookmark(
    ) async -> PostResponse? {
        let request = PostsAPIFactory.makeRecentRequest(count: 1)
        let response = try? await networkClient.run(request)

        return response?.value.posts.first
    }

    private func needsBookmarksUpdate(
    ) async -> Bool {
        let request = UpdateAPIFactory.makeUpdateRequest()
        let response = try? await networkClient.run(request)

        guard settingsStore.lastSyncDate != response?.value.updateTime else {
            return false
        }

        settingsStore.lastSyncDate = response?.value.updateTime

        return true
    }

    private func addBookmark(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: String? = nil,
        shared: String? = nil,
        toread: String? = nil
    ) async -> Bool {
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
        let response = try? await networkClient.run(request)

        return response?.value.resultCode == "done"
    }

    public func addBookmark(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: String? = nil,
        shared: String? = nil,
        toread: String? = nil
    ) async -> PostResponse? {
        let didAddBookmark: Bool = await addBookmark(
            url: url,
            description: description,
            extended: extended,
            tags: tags,
            date: date,
            replace: replace,
            shared: shared,
            toread: toread
        )

        guard didAddBookmark == true else {
            return nil
        }

        return await lastBookmark()
    }
}
