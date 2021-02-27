import Foundation

final class AnyTokenStore: TokenStoreProtocol, ObservableObject {

    // MARK: - Properties

    private var tokenStore: TokenStoreProtocol

    /// Auth token required to perform the network requests.
    var authToken: String? {
        get { tokenStore.authToken }
        set { tokenStore.authToken = newValue }
    }

    // MARK: - Life cycle

    init(
        _ tokenStore: TokenStoreProtocol
    ) {
        self.tokenStore = tokenStore
    }
}
