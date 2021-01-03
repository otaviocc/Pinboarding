import Foundation
import Combine

final class RefreshViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var isReloading = false

    private let repository: PinboardRepository
    private var cancellable: AnyCancellable?

    // MARK: - Life cycle

    init(
        repository: PinboardRepository
    ) {
        self.repository = repository
    }

    // MARK: - Public

    func refresh(
    ) {
        isReloading = true
        cancellable?.cancel()

        cancellable = repository.forceRefreshBookmarksPublisher()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue:  { _ in self.isReloading = false }
            )
    }
}
