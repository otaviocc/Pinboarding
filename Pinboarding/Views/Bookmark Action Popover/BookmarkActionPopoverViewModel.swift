import Combine
import Foundation

final class BookmarkActionPopoverViewModel: ObservableObject {

    // MARK: - Properties

    let isPrivate: Bool
    let title: String
    let url: URL
    let showMicroBlog: Bool

    // MARK: - Life cycle

    init(
        isPrivate: Bool,
        title: String,
        url: URL,
        settingsStore: SettingsStore
    ) {
        self.isPrivate = isPrivate
        self.title = title
        self.url = url
        self.showMicroBlog = settingsStore.showMicroBlog
    }
}
