import MicroClient
import MicroPinboard

final class PinboardingAppEnvironment {

    // MARK: - Properties

    let searchStore = SearchStore()

    let settingsStore = SettingsStore(
        userDefaults: .standard
    )

    let tokenStore = AnyTokenStore(SecureStore())

    let persistenceService = PersistenceService(
        inMemory: false
    )

    let apiFactory = PinboardAPIFactory()

    private(set) lazy var networkClient = apiFactory.makePinboardAPIClient(
        userToken: { self.tokenStore.authToken }
    )

    private(set) lazy var networkService = NetworkService(
        settingsStore: settingsStore,
        networkClient: networkClient
    )

    private(set) lazy var repository = PinboardRepository(
        networkService: networkService,
        persistenceService: persistenceService
    )
}
