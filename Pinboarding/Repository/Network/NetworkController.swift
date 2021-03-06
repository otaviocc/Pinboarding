import Combine
import Foundation
import PinboardKit

final class NetworkController {

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()
    private let pinboardAPI: PinboardAPI
    private let settingsStore: SettingsStore
    private let tokenStore: AnyTokenStore
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
        tokenStore: AnyTokenStore
    ) {
        self.settingsStore = settingsStore
        self.tokenStore = tokenStore
        self.pinboardAPI = PinboardAPI {
            tokenStore.authToken
        }

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
        pinboardAPI.eventPublisher()
            .map { event in
                switch event {
                case .loading:
                    return .loading
                case .finishedLoading:
                    return .finishedLoading
                case .errorLoading:
                    return .errorLoading
                }
            }
            .eraseToAnyPublisher()
    }

    /// Publishes a new bookmark and retrieve the
    /// latest post. The Pinboard API doesn't return
    /// the added bookmark on the payload, so it's necessary
    /// to make an additional request to get it.
    func addBookmarkPublisher(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: String? = nil,
        shared: String? = nil,
        toread: String? = nil
    ) -> AnyPublisher<PostResponse, Error> {
        pinboardAPI.addPublisher(
            url: url,
            description: description,
            extended: extended,
            tags: tags,
            date: date,
            replace: replace,
            shared: shared,
            toread: toread
        )
        .filter { $0.resultCode == "done" }
        .flatMap { _ in self.lastBookmarkPublisher() }
        .eraseToAnyPublisher()
    }

    /// Publishes all bookmarks without waiting for the next
    /// x minutes to pass. Used to force a full refresh.
    func forceRefreshBookmarksPublisher(
    ) -> AnyPublisher<[PostResponse], Error> {
        pinboardAPI.updatePublisher()
            .map(\.updateTime)
            .filter { $0 != self.settingsStore.lastSyncDate }
            .map { self.settingsStore.lastSyncDate = $0 }
            .flatMap { _ in self.pinboardAPI.allPublisher() }
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    /// Pinboard API doesn't return the diff between two dates,
    /// so there's no way to know if something got removed. The only
    /// way to do that is by retrieving all the bookmarks again. For
    /// that reason it's important to check the date of the latest
    /// change (which includes add, edit, and remove).
    private func allBookmarksPublisher(
    ) -> AnyPublisher<[PostResponse], Error> {
        pinboardAPI.updatePublisher()
            .map(\.updateTime)
            .filter { $0 != self.settingsStore.lastSyncDate }
            .map { self.settingsStore.lastSyncDate = $0 }
            .flatMap { _ in self.pinboardAPI.allPublisher() }
            .eraseToAnyPublisher()
    }

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
            .flatMap { _ in self.allBookmarksPublisher() }
            .eraseToAnyPublisher()
    }

    /// Publishes the latest bookmark.
    private func lastBookmarkPublisher(
    ) -> AnyPublisher<PostResponse, Error> {
        pinboardAPI.recentsPublisher(count: 1)
            .compactMap(\.posts.first)
            .eraseToAnyPublisher()
    }
}
