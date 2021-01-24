import Foundation
import Combine

extension Preview {

    // MARK: - Nested types

    final class InMemoryTokenStore: TokenStoreProtocol, ObservableObject {
        var authToken: String?

        init(
            authToken: String?
        ) {
            self.authToken = authToken
        }
    }

    /// In memory Token Store for SwiftUI Previews, so
    /// that KeyChain isn't accesses for previews.
    static func makeTokenStore(
        authToken: String
    ) -> InMemoryTokenStore {
        InMemoryTokenStore(
            authToken: authToken
        )
    }
}
