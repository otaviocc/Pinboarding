import Foundation
import Combine
import PinboardKit

final class BookmarksViewModel: ObservableObject {

    // MARK: - Properties

    @Published var bookmarks: [Bookmark] = []

    private let repository: PinboardRepository
    private let settingsStore: SettingsStoreProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        store: SettingsStoreProtocol = SettingsStore.shared
    ) {
        self.settingsStore = store

        self.repository = PinboardRepository(
            pinboardAPI: PinboardAPI { store.authToken }
        )

        self.repository
            .recentBookmarks()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { self.bookmarks = $0 }
            )
            .store(in: &cancellables)
    }
}
