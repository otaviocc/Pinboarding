import Foundation
import Combine

final class SidebarViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var isLoading = false

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        networkActivityPublisher: AnyPublisher<NetworkActivityEvent, Never>
    ) {
        networkActivityPublisher
            .receive(on: RunLoop.main)
            .map { $0 == .loading }
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
    }
}
