import Combine
import Foundation

final class BookmarkActionPopoverViewModel: ObservableObject {

    // MARK: - Properties

    let isPrivate: Bool
    let title: String
    let url: URL
    let showMicroBlog: Bool

    private let repository: PinboardRepositoryProtocol

    // MARK: - Life cycle

    init(
        isPrivate: Bool,
        title: String,
        url: URL,
        repository: PinboardRepositoryProtocol,
        settingsStore: SettingsStore
    ) {
        self.isPrivate = isPrivate
        self.title = title
        self.url = url
        self.repository = repository
        self.showMicroBlog = settingsStore.showMicroBlog
    }

    func deleteBookmark() {
        Task {
            await repository.deleteBookmark(url: url)
        }
    }
}
