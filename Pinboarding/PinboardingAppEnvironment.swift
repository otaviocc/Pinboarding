import Foundation

final class PinboardingAppEnvironment {

    // MARK: - Properties

    private(set) var userDefaultsStore = UserDefaultsStoreStore(
        userDefaults: .standard
    )

    private(set) lazy var networkController = NetworkController(
        userDefaultsStore: userDefaultsStore
    )

    private(set) lazy var persistenceController = PersistenceController(
        inMemory: false,
        updatesPublisher: networkController.allBookmarksUpdatesPublisher()
    )

    private(set) lazy var repository = PinboardRepository(
        networkController: networkController,
        persistenceController: persistenceController
    )
}
