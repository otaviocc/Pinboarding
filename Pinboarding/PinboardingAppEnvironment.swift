import Foundation

final class PinboardingAppEnvironment {

    // MARK: - Properties

    let searchStore = SearchStore()

    let persistenceController = PersistenceController(
        inMemory: false
    )

    let userDefaultsStore = UserDefaultsStore(
        userDefaults: .standard
    )

    private(set) lazy var networkController = NetworkController(
        userDefaultsStore: userDefaultsStore
    )

    private(set) lazy var repository = PinboardRepository(
        networkController: networkController,
        persistenceController: persistenceController
    )
}
