import SwiftUI

struct BookmarkCommands: Commands {

    // MARK: - Properties

    private let repository: PinboardRepository

    // MARK: - Life cycle

    init(
        repository: PinboardRepository
    ) {
        self.repository = repository
    }

    // MARK: - Public

    var body: some Commands {
        CommandMenu("Bookmark") {
            Button("Refresh Bookmarks") {
                repository.forceRefreshBookmarks()
            }
            .keyboardShortcut("r")
        }
    }
}
