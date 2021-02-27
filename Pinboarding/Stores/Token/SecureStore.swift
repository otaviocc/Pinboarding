import Foundation

final class SecureStore: ObservableObject {

    // MARK: - Properties

    /// Auth token required to perform the network requests.
    @SecureStorage("authToken") var authToken: String?
}

extension SecureStore: TokenStoreProtocol {}
