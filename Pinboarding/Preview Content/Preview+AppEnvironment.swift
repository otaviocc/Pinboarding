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

    let persistenceController = Preview.makePersistenceController(
        populated: true
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

let previewAppEnvironment = PreviewAppEnvironment()
