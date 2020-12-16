import Combine
import Foundation

final class LoginViewModel: ObservableObject {

    // MARK: - Properties

    @Published var authToken: String = ""
}
