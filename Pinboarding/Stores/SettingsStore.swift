import Combine
import Foundation

final class SettingsStore: ObservableObject {

    // MARK: - Nested types

    private enum Key {
        static let authToken = "settingsAuthToken"
        static let isPrivate = "settingsIsPrivate"
        static let isToRead = "settingsIsToRead"
        static let showPrivateIcon = "settingsShowPrivateIcon"
    }

    // MARK: - Properties

    var isPrivate: Bool {
        get { userDefaults.bool(forKey: Key.isPrivate) }
        set {
            userDefaults.setValue(
                newValue,
                forKey: Key.isPrivate
            )
            changesSubject.send(
                .isPrivate(isPrivate)
            )
        }
    }

    var isToRead: Bool {
        get { userDefaults.bool(forKey: Key.isToRead) }
        set {
            userDefaults.setValue(
                newValue,
                forKey: Key.isToRead
            )
            changesSubject.send(
                .isToRead(isToRead)
            )
        }
    }

    var authToken: String {
        get { userDefaults.string(forKey: Key.authToken) ?? "" }
        set {
            userDefaults.setValue(
                newValue,
                forKey: Key.authToken
            )
            changesSubject.send(
                .authToken(authToken)
            )
        }
    }

    var showPrivateIcon: Bool {
        get { userDefaults.bool(forKey: Key.showPrivateIcon) }
        set {
            userDefaults.setValue(
                newValue,
                forKey: Key.showPrivateIcon
            )
            changesSubject.send(
                .showPrivateIcon(showPrivateIcon)
            )
        }
    }

    private let userDefaults: UserDefaults
    private let changesSubject = PassthroughSubject<SettingsStoreChange, Never>()

    // MARK: - Life cycle

    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }

    // MARK: - Public

    func changesPublisher() -> AnyPublisher<SettingsStoreChange, Never> {
        changesSubject
            .eraseToAnyPublisher()
    }
}
