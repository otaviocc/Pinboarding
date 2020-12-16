import Combine
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var authToken: String = ""
}
