import MicroClient
import MicroPinboard

final class PreviewAppEnvironment {

    // MARK: - Properties

    let searchStore = Preview.makeSearchStore()
    let settingsStore = Preview.makeSettingsStore()

    let tokenStore = AnyTokenStore(
        Preview.makeTokenStore(
            authToken: "token"
        )
    )

    let persistenceService = Preview.makePersistenceController(
        populated: true
    )

    private(set) lazy var networkClient = PinboardAPIFactory().makePinboardAPIClient(
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

let previewAppEnvironment = PreviewAppEnvironment()
