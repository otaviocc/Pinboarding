import Combine
import MicroClient
import MicroPinboard
import MicroContainer
import Network

final class PinboardingAppEnvironment {

    // MARK: - Properties

    private let container = DependencyContainer()

    var viewModelFactory: ViewModelFactory { container.resolve() }
    var repository: PinboardRepositoryProtocol { container.resolve() }
    var searchStore: SearchStore { container.resolve() }
    var persistenceService: PersistenceServiceProtocol { container.resolve() }
    var navigationModel: NavigationModel { container.resolve() }

    // MARK: - Life cycle

    init(
    ) {
        container.register(
            type: SearchStore.self,
            allocation: .static
        ) { _ in
            SearchStore()
        }

        container.register(
            type: SettingsStore.self,
            allocation: .static
        ) { _ in
            SettingsStore(
                userDefaults: .standard
            )
        }

        container.register(
            type: TokenStoreProtocol.self,
            allocation: .static
        ) { _ in
            SecureStore()
        }

        container.register(
            type: PersistenceServiceProtocol.self,
            allocation: .static
        ) { _ in
            PersistenceService(
                inMemory: false
            )
        }

        container.register(
            type: NetworkClientProtocol.self,
            allocation: .static
        ) { container in
            PinboardAPIFactory()
                .makePinboardAPIClient(
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
            type: PinboardRepositoryProtocol.self,
            allocation: .static
        ) { container in
            PinboardRepository(
                networkService: container.resolve(),
                persistenceService: container.resolve()
            )
        }

        container.register(
            type: NWPathMonitorPathPublishing.self,
            allocation: .static
        ) { _ in
            NWPathMonitor()
        }

        container.register(
            type: ViewModelFactory.self,
            allocation: .static
        ) { container in
            ViewModelFactory(
                container: container
            )
        }

        container.register(
            type: NavigationModel.self,
            allocation: .static
        ) { _ in
            NavigationModel()
        }
    }
}
