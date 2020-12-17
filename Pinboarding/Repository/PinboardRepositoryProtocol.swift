import Combine
import Foundation

protocol PinboardRepositoryProtocol {

    /// Adds a bookmark.
    func addBookmark(
        url: URL,
        description: String,
        extended: String?,
        tags: String?,
        date: Date?,
        replace: Bool?,
        shared: Bool?,
        toread: Bool?
    ) -> AnyPublisher<Bool, Error>

    /// Deletes a bookmark.
    func deleteBookmark(
        url: URL
    ) -> AnyPublisher<Bool, Error>

    /// Returns all bookmarks in the user's account.
    func allBookmarks(
        tag: String?,
        start: Int?,
        results: Int?,
        fromDate: Date?,
        toDate: Date?,
        meta: Int?
    ) -> AnyPublisher<[Bookmark], Error>

    /// Returns a list of the user's most recent posts, filtered by tag.
    func recentBookmarks(
        tag: String?,
        count: Int?
    ) -> AnyPublisher<[Bookmark], Error>
}
