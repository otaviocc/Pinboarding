import Foundation
import Combine
import PinboardKit

final class BookmarksViewModel: ObservableObject {

    // MARK: - Properties

    @Published var bookmarks: [Bookmark] = []

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Life cycle

    init(
        repository: PinboardRepositoryProtocol
    ) {
        repository.allBookmarksPublisher()
            .receive(on: RunLoop.main)
            .sink { [weak self] bookmarks in
                self?.bookmarks = bookmarks
            }
            .store(in: &cancellables)
    }
}
