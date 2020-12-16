import Combine
import Foundation

final class AddBookmarkViewModel: ObservableObject {

    // MARK: - Properties

    @Published var urlString: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var tags: String = ""
}
