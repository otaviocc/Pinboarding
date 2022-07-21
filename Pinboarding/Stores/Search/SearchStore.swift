import Combine
import Foundation

final class SearchStore: ObservableObject {

    // MARK: - Properties

    /// Search Term Input.
    @Published var currentSearchTerm: String = ""

    /// Search Term Output (debounce + remove duplicates).
    @Published private(set) var searchTerm: String = ""

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
    ) {
        self.searchTermPublisher()
            .assign(to: \.searchTerm, on: self)
            .store(in: &cancellables)
    }

    // MARK: - Private

    private func searchTermPublisher(
    ) -> AnyPublisher<String, Never> {
        $currentSearchTerm
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
