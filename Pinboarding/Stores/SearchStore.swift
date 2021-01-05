import Combine

final class SearchStore: ObservableObject {

    // MARK: - Properties

    @Published var currentSearchTerm: String = ""
}
