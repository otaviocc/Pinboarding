import Foundation
import Combine

final class SearchTextViewModel: ObservableObject {

    // MARK: - Properties

    @Published var currentSearchTerm: String

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        searchStore: SearchStore
    ) {
        self.currentSearchTerm = searchStore.currentSearchTerm

        searchTermPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.currentSearchTerm, on: searchStore)
            .store(in: &cancellables)
    }

    // MARK: - Public

    func clear() {
        currentSearchTerm = ""
    }

    // MARK: - Private

    private func searchTermPublisher(
    ) -> AnyPublisher<String, Never> {
        $currentSearchTerm
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
