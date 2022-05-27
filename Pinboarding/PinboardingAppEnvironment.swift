import MicroClient
import MicroPinboard
import MicroContainer

final class PinboardingAppEnvironment {

    // MARK: - Properties

    private let container = DependencyContainer()

    var repository: PinboardRepository { container.resolve() }
    var settingsStore: SettingsStore { container.resolve() }
    var tokenStore: AnyTokenStore { container.resolve() }
    var searchStore: SearchStore { container.resolve() }
    var persistenceService: PersistenceServiceProtocol { container.resolve() }

    // MARK: - Life cycle

    init() {
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
            type: AnyTokenStore.self,
            allocation: .static
        ) { _ in
            AnyTokenStore(
                SecureStore()
            )
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
                        let tokenStore: AnyTokenStore = container.resolve()
                        return tokenStore.authToken
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
    }
}
