import MicroClient
import MicroPinboard

final class DependencyContainer {

    private var dependencies: [DependencyKey: Any] = [:]

    func register<T>(
        type: T.Type,
        name: String? = nil,
        service: Any
    ) {
        let dependencyKey = DependencyKey(
            type: type,
            name: name
        )

        dependencies[dependencyKey] = service
    }

    func resolve<T>(
        type: T.Type,
        name: String? = nil
    ) -> T {
        let dependencyKey = DependencyKey(
            type: type,
            name: name
        )

        guard let dependency = dependencies[dependencyKey] as? T else {
            fatalError("Missing dependency")
        }

        return dependency
    }
}

final class DependencyKey: Hashable, Equatable {
    private let type: Any.Type
    private let name: String?

    init(
        type: Any.Type,
        name: String? = nil
    ) {
        self.type = type
        self.name = name
    }

    func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(ObjectIdentifier(type))
        hasher.combine(name)
    }

    static func == (lhs: DependencyKey, rhs: DependencyKey) -> Bool {
        return lhs.type == rhs.type && lhs.name == rhs.name
    }
}

final class PinboardingAppContainer {

    let container = DependencyContainer()

    init() {
        container.register(
            type: SearchStore.self,
            service: SearchStore()
        )

        container.register(
            type: SettingsStore.self,
            service: SettingsStore(
                userDefaults: .standard
            )
        )

        container.register(
            type: AnyTokenStore.self,
            service: AnyTokenStore(
                SecureStore()
            )
        )

        container.register(
            type: PersistenceServiceProtocol.self,
            service: PersistenceService(
                inMemory: false
            )
        )

        container.register(
            type: NetworkClientProtocol.self,
            service: PinboardAPIFactory()
                .makePinboardAPIClient(
                    userToken: { [unowned self] in
                        let tokenStore = container.resolve(type: AnyTokenStore.self)
                        return tokenStore.authToken
                    }
                )
        )

        container.register(
            type: NetworkServiceProtocol.self,
            service: NetworkService(
                settingsStore: container.resolve(type: SettingsStore.self),
                networkClient: container.resolve(type: NetworkClientProtocol.self)
            )
        )

        container.register(
            type: PinboardRepository.self,
            service: PinboardRepository(
                networkService: container.resolve(type: NetworkServiceProtocol.self),
                persistenceService: container.resolve(type: PersistenceServiceProtocol.self)
            )
        )
    }
}
