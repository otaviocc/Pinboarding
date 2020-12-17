import Foundation
import Combine
import PinboardKit

final class BookmarksViewModel: ObservableObject {

    // MARK: - Properties

    @Published var bookmarks: [Bookmark] = []

    private let repository: PinboardRepository
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
    ) {
        self.repository = PinboardRepository(
            pinboardAPI: PinboardAPI { "USER:TOKEN" }
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
