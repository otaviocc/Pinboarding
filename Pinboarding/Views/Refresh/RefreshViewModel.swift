import Combine
import Foundation

final class RefreshViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var isReloading = false

    private let repository: PinboardRepository
    private var activityCancellable: AnyCancellable?

    // MARK: - Life cycle

    init(
        repository: PinboardRepository
    ) {
        self.repository = repository

        self.activityCancellable = repository.networkActivityPublisher()
            .receive(on: RunLoop.main)
            .map { $0 == .loading }
            .assign(to: \.isReloading, on: self)
    }

    // MARK: - Public

    func refresh(
    ) {
        Task {
            await repository.forceRefreshBookmarks()
        }
    }
}
