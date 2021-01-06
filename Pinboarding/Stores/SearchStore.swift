import Combine

final class SearchStore: ObservableObject {

    // MARK: - Properties

    /// Search term used across the app.
    @Published var searchTerm: String = ""
}
