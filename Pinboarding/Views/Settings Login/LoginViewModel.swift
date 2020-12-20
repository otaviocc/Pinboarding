import Combine
import Foundation

final class LoginViewModel: ObservableObject {

    // MARK: - Properties

    @Published var authToken: String = ""
    @Published private(set) var authTokenMessage: String = ""
    @Published private(set) var isValid = false

    private var settingsStore: SettingsStoreProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(
        settingsStore: SettingsStoreProtocol = SettingsStore.shared
    ) {
        self.settingsStore = settingsStore
        self.authToken = settingsStore.authToken

        self.isAuthTokenValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)

        self.isAuthTokenValidPublisher
            .receive(on: RunLoop.main)
            .map { isAuthValid in
                isAuthValid ? "" : "Auth Token must contain ':'"
            }
            .assign(to: \.authTokenMessage, on: self)
            .store(in: &cancellables)
    }

    // MARK: - Public

    func save() {
        guard isValid else { return }

        settingsStore.authToken = authToken
    }

    // MARK: - Private

    private var isAuthTokenValidPublisher: AnyPublisher<Bool, Never> {
        $authToken
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .map(isAuthTokenValid)
            .eraseToAnyPublisher()
    }

    private func isAuthTokenValid(
        _ token: String
    ) -> Bool {
        guard
            case let components = token.split(separator: ":"),
            components.count == 2,
            let user = components.first,
            let key = components.last,
            user.count > 0,
            key.count > 0
        else { return false }

        return true
    }
}
