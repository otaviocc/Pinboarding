final class PinboardingAppEnvironment {

    // MARK: - Properties

    let searchStore = SearchStore()

    let settingsStore = SettingsStore(
        userDefaults: .standard
    )

    let tokenStore = AnyTokenStore(SecureStore())

    let persistenceController = PersistenceController(
        inMemory: false
    )

    private(set) lazy var networkController = NetworkController(
        settingsStore: settingsStore,
        tokenStore: tokenStore
    )

    private(set) lazy var repository = PinboardRepository(
        networkController: networkController,
        persistenceController: persistenceController
    )
}
