import SwiftUI

struct BookmarkCommands: Commands {

    // MARK: - Properties

    private let repository: PinboardRepositoryProtocol

    // MARK: - Life cycle

    init(
        repository: PinboardRepositoryProtocol
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
