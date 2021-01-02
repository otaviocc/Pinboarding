import Combine
import Foundation

extension Preview {

    /// Repository for Swift UI Previews.
    static func makeRepository(
    ) -> PinboardRepository {
        PinboardRepository(
            networkController: Preview.makeNetworkController(),
            persistenceController: Preview.makePersistenceController()
        )
    }
}
