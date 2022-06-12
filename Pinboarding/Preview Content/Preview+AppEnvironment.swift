import MicroClient
import MicroPinboard
import MicroContainer

final class PreviewAppEnvironment {

    // MARK: - Properties

    private let container = DependencyContainer()

    var viewModelFactory: ViewModelFactory { container.resolve() }
    var repository: PinboardRepository { container.resolve() }
    var settingsStore: SettingsStore { container.resolve() }
    var tokenStore: TokenStoreProtocol { container.resolve() }
    var searchStore: SearchStore { container.resolve() }
    var persistenceService: PersistenceServiceProtocol { container.resolve() }

    // MARK: - Life cycle

    init(
    ) {
        container.register(
            type: SearchStore.self,
            allocation: .static
        ) { _ in
            Preview.makeSearchStore()
        }

        container.register(
            type: SettingsStore.self,
            allocation: .static
        ) { _ in
            Preview.makeSettingsStore()
        }

        container.register(
            type: TokenStoreProtocol.self,
            allocation: .static
        ) { _ in
            Preview.makeTokenStore(
                authToken: "token"
            )
        }

        container.register(
            type: PersistenceServiceProtocol.self,
            allocation: .static
        ) { _ in
            Preview.makePersistenceController(
                populated: true
            )
        }

        container.register(
            type: NetworkClientProtocol.self,
            allocation: .static
        ) { container in
            PinboardAPIFactory().makePinboardAPIClient(
                userToken: {
                    (container.resolve() as TokenStoreProtocol).authToken
                }
            )
        }

        container.register(
            type: NetworkServiceProtocol.self,
            allocation: .static
        ) { container in
            NetworkService(
                settingsStore: container.resolve(),
                networkClient: container.resolve()
            )
        }

        container.register(
            type: PinboardRepository.self,
            allocation: .static
        ) { container in
            PinboardRepository(
                networkService: container.resolve(),
                persistenceService: container.resolve()
            )
        }

        container.register(
            type: ViewModelFactory.self,
            allocation: .static
        ) { container in
            ViewModelFactory(
                container: container
            )
        }
    }
}

let previewAppEnvironment = PreviewAppEnvironment()
