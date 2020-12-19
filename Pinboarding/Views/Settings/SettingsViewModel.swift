import Combine
import Foundation

final class SettingsViewModel: ObservableObject {

    // MARK: - Properties

    @Published var authToken: String = ""
}
