import Combine
import Foundation
import MicroPinboard

protocol PinboardRepositoryProtocol {

    /// Adds a new bookmark.
    func addBookmark(
        url: URL,
        title: String,
        description: String?,
        tags: String?,
        date: Date?,
        replace: Bool,
        shared: Bool,
        toread: Bool
    ) async throws

    /// Deletes a bookmark.
    func deleteBookmark(
        url: URL
    ) async

    /// Forces an update without waiting for the next
    /// x minutes to pass.
    func forceRefreshBookmarks(
    ) async

    /// Publishes the network status to update the UI
    /// during update requests.
    func networkActivityPublisher(
    ) -> AnyPublisher<NetworkActivityEvent, Never>
}

final class PinboardRepository: PinboardRepositoryProtocol {

    // MARK: - Properties

    private let persistenceService: PersistenceServiceProtocol
    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        networkService: NetworkServiceProtocol,
        persistenceService: PersistenceServiceProtocol
    ) {
        self.networkService = networkService
        self.persistenceService = persistenceService

        networkService
            .allBookmarksUpdatesPublisher()
            .sink { bookmarks in
                persistenceService.addAllPosts(bookmarks)
            }
            .store(in: &cancellables)
    }

    func addBookmark(
        url: URL,
        title: String,
        description: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: Bool = false,
        shared: Bool = false,
        toread: Bool = false
    ) async throws {
        let bookmark = try await networkService.addBookmark(
            url: url,
            description: title,
            extended: description,
            tags: tags,
            date: date,
            replace: replace.stringValue,
            shared: shared.stringValue,
            toread: toread.stringValue
        )

        persistenceService.appendNewPost(bookmark)
    }

    func deleteBookmark(
        url: URL
    ) async {
        guard let _ = try? await networkService.deleteBookmark(url: url) else {
            return
        }

        DispatchQueue.main.async { [persistenceService] in
            persistenceService.deleteBookmark(url)
        }
    }

    func forceRefreshBookmarks(
    ) async {
        guard let bookmarks = try? await networkService.allBookmarks() else {
            return
        }

        DispatchQueue.main.async { [persistenceService] in
            persistenceService.addAllPosts(bookmarks)
        }
    }

    func networkActivityPublisher(
    ) -> AnyPublisher<NetworkActivityEvent, Never> {
        networkService.networkActivityPublisher()
    }
}
