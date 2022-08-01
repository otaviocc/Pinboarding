import Combine
import Foundation

final class BookmarkViewModel {

    // MARK: - Properties

    let title: String
    let description: String
    let tags: String
    let url: URL
    let hostURL: String
    let iconURL: URL?
    let isPrivate: Bool

    // MARK: - Life cycle

    init(
        title: String,
        description: String,
        tags: String,
        url: URL,
        hostURL: String,
        iconURL: URL?,
        isPrivate: Bool
    ) {
        self.title = title
        self.description = description
        self.tags = tags
        self.url = url
        self.hostURL = hostURL
        self.iconURL = iconURL
        self.isPrivate = isPrivate
    }

    init(
        bookmark: Bookmark
    ) {
        self.title = bookmark.title
        self.description = bookmark.abstract
        self.url = URL(string: bookmark.href)
            ?? URL(string: "https://www.pinboard.in")!
        self.hostURL = url.host?.uppercased() ?? ""
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
