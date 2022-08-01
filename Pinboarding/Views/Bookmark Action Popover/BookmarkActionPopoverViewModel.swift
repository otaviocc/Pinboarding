import Combine
import Foundation

final class BookmarkActionPopoverViewModel: ObservableObject {

    // MARK: - Properties

    let isPrivate: Bool
    let title: String
    let url: URL

    // MARK: - Life cycle

    init(
        isPrivate: Bool,
        title: String,
        url: URL
    ) {
        self.isPrivate = isPrivate
        self.title = title
        self.url = url
    }
}
