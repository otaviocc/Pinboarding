import Combine
import Foundation
import MicroPinboard

public class PinboardRepository: ObservableObject {

    // MARK: - Properties

    private let persistenceService: PersistenceService
    private let networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()
    private var refreshCancellable: AnyCancellable?

    // MARK: - Life cycle

    init(
        networkService: NetworkService,
        persistenceService: PersistenceService
    ) {
        self.networkService = networkService
        self.persistenceService = persistenceService

        networkService.allBookmarksUpdatesPublisher()
            .sink { bookmarks in
                persistenceService.addAllPosts(bookmarks)
            }
            .store(in: &cancellables)
    }

    /// Adds a new bookmark.
    func addBookmark(
        url: URL,
        title: String,
        description: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: Bool = false,
        shared: Bool = false,
        toread: Bool = false
    ) async {
        Task {
            let bookmark = await networkService.addBookmark(
                url: url,
                description: title,
                extended: description,
                tags: tags,
                date: date,
                replace: replace.stringValue,
                shared: shared.stringValue,
                toread: toread.stringValue
            )

            guard let bookmark = bookmark else {
                return
            }

            persistenceService.appendNewPostPublisher(bookmark)
        }
    }

    /// Forces an update without waiting for the next
    /// x minutes to pass.
    func forceRefreshBookmarks(
    ) async {
        let bookmarks = await networkService.allBookmarks()

        persistenceService.addAllPosts(bookmarks)
    }

    /// Publishes the network status to update the UI
    /// during update requests.
    func networkActivityPublisher(
    ) -> AnyPublisher<NetworkActivityEvent, Never> {
        networkService.networkActivityPublisher()
    }
}
