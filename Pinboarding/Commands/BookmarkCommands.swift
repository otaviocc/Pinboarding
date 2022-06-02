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
        CommandGroup(replacing: .newItem) { }

        CommandMenu("Bookmarks") {
            Button("Refresh Bookmarks") {
                Task {
                    await repository.forceRefreshBookmarks()
                }
            }
            .keyboardShortcut("r")
        }
    }
}
