import Foundation
import Combine

final class SidebarViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isLoading = false

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Life cycle

    init(
        networkActivityPublisher: AnyPublisher<NetworkControllerEvent, Never>
    ) {
        networkActivityPublisher
            .map { $0 == .loading }
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
    }
}
