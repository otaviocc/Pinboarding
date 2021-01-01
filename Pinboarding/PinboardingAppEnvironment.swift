import Foundation

final class PinboardingAppEnvironment {

    // MARK: - Properties

    private(set) var userDefaultsStore = UserDefaultsStore(
        userDefaults: .standard
    )

    private(set) lazy var networkController = NetworkController(
        userDefaultsStore: userDefaultsStore
    )

    private(set) lazy var persistenceController = PersistenceController(
        inMemory: false,
        allBookmarksUpdatesPublisher: networkController.allBookmarksUpdatesPublisher()
    )

    private(set) lazy var repository = PinboardRepository(
        networkController: networkController,
        persistenceController: persistenceController
    )
}
