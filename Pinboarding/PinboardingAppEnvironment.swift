import Foundation

final class PinboardingAppEnvironment {

    // MARK: - Properties

    let searchStore = SearchStore()

    let persistenceController = PersistenceController(
        inMemory: false
    )

    let settingsStore = SettingsStore(
        userDefaults: .standard
    )

    private(set) lazy var networkController = NetworkController(
        settingsStore: settingsStore
    )

    private(set) lazy var repository = PinboardRepository(
        networkController: networkController,
        persistenceController: persistenceController
    )
}
