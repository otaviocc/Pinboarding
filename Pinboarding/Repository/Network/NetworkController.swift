import Combine
import Foundation
import PinboardKit

final class NetworkController {

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()
    private let pinboardAPI: PinboardAPI
    private let userDefaultsStore: UserDefaultsStore
    private let postResponseSubject =
        PassthroughSubject<[PostResponse], Never>()

    // MARK: - Life cycle

    init(
        userDefaultsStore: UserDefaultsStore
    ) {
        self.userDefaultsStore = userDefaultsStore
        self.pinboardAPI = PinboardAPI {
            userDefaultsStore.authToken
        }

        recentBookmarksPublisher()
            .receive(on: RunLoop.main)
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
        pinboardAPI.add(
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

    // MARK: - Private

    /// Pinboard API doesn't return the diff between two dates,
    /// so there's no way to know if something got removed. The only
    /// way to do that is by retrieving all the bookmarks again. For
    /// that reason it's important to check the date of the latest
    /// change (which includes add, edit, and remove).
    private func allBookmarksPublisher(
    ) -> AnyPublisher<[PostResponse], Error> {
        pinboardAPI.update()
            .map { $0.updateTime }
            .filter { $0 != self.userDefaultsStore.lastSyncDate }
            .map { self.userDefaultsStore.lastSyncDate = $0 }
            .flatMap { _ in self.pinboardAPI.all() }
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
                interval: 15,
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
        pinboardAPI.recents(count: 1)
            .compactMap { $0.posts.first }
            .eraseToAnyPublisher()
    }
}
