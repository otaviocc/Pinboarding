import Combine
import Foundation

protocol BookmarkViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var tags: String { get }
    var url: URL { get }
    var iconURL: URL? { get }
    var isPrivate: Bool { get }
}

final class BookmarkViewModel: BookmarkViewModelProtocol {

    // MARK: - Properties

    let title: String
    let description: String
    let tags: String
    let url: URL
    let iconURL: URL?
    let isPrivate: Bool

    // MARK: - Life cycle

    init(
        bookmark: Bookmark
    ) {
        self.title = bookmark.title
        self.description = bookmark.abstract
        self.url = URL(string: bookmark.href)
            ?? URL(string: "https://www.pinboard.in")!
        self.iconURL = URL(
            string: "https://www.google.com/s2/favicons?sz=16&domain=\(url.host!)"
        )
        self.tags = bookmark.tags
            .compactMap { $0 as? Tag }
            .map(\.name)
            .joined(separator: ", ")
        self.isPrivate = !bookmark.isShared
    }
}
