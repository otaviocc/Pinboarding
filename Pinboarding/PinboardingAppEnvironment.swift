import MicroClient
import MicroPinboard

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

    private(set) lazy var networkClient = PinboardAPIFactory().makePinboardAPIClient(
        userToken: { self.tokenStore.authToken }
    )

    private(set) lazy var networkController = NetworkController(
        settingsStore: settingsStore,
        networkClient: networkClient
    )

    private(set) lazy var repository = PinboardRepository(
        networkController: networkController,
        persistenceController: persistenceController
    )
}
