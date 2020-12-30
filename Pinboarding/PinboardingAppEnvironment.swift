import Foundation

final class PinboardingAppEnvironment {

    // MARK: - Properties

    private(set) var settingsStore = SettingsStore(
        userDefaults: .standard
    )

    private(set) lazy var networkController = NetworkController(
        settingsStore: settingsStore
    )

    private(set) lazy var persistenceController = PersistenceController(
        inMemory: false
    )

    private(set) lazy var repository = PinboardRepository(
        networkController: networkController,
        persistenceController: persistenceController
    )
}
