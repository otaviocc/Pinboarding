import Combine

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
