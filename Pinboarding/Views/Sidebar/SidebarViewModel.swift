import Combine
import Foundation
import SwiftUI

final class SidebarViewModel: ObservableObject {

    // MARK: - Properties

    @Published var currentSearchTerm: String
    @Published private(set) var isLoading = false

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        networkActivityPublisher: AnyPublisher<NetworkActivityEvent, Never>,
        searchStore: SearchStore
    ) {
        self.currentSearchTerm = searchStore.currentSearchTerm

        networkActivityPublisher
            .receive(on: RunLoop.main)
            .map { $0 == .loading }
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)

        searchTermPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.currentSearchTerm, on: searchStore)
            .store(in: &cancellables)
    }

    private func searchTermPublisher(
    ) -> AnyPublisher<String, Never> {
        $currentSearchTerm
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}
