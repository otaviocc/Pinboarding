import Combine
import Foundation

final class LoginViewModel: ObservableObject {

    // MARK: - Properties

    @Published var authToken: String = ""
    @Published private(set) var authTokenMessage: String = ""
    @Published private(set) var isValid = false

    private var tokenStore: TokenStoreProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        tokenStore: TokenStoreProtocol
    ) {
        self.tokenStore = tokenStore
        self.authToken = tokenStore.authToken ?? ""

        self.isAuthTokenValidPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)

        self.isAuthTokenValidPublisher()
            .receive(on: RunLoop.main)
            .map { isAuthValid in
                isAuthValid ? "" : "Please enter a valid token"
            }
            .assign(to: \.authTokenMessage, on: self)
            .store(in: &cancellables)
    }

    // MARK: - Public

    func save() {
        guard isValid else {
            return
        }

        tokenStore.authToken = authToken
    }

    // MARK: - Private

    private func isAuthTokenValidPublisher(
    ) -> AnyPublisher<Bool, Never> {
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
            !user.isEmpty,
            !key.isEmpty
        else { return false }

        return true
    }
}
