import Combine
import Foundation

final class UserDefaultsStore: ObservableObject {

    // MARK: - Nested types

    private enum Key {
        static let authToken = "settingsAuthToken"
        static let isPrivate = "settingsIsPrivate"
        static let isToRead = "settingsIsToRead"
        static let lastSyncDate = "syncLastUpdate"
    }

    // MARK: - Properties

    private let userDefaults: UserDefaults
    private let changesSubject =
        PassthroughSubject<UserDefaultsStoreChange, Never>()

    // MARK: - Life cycle

    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }

    // MARK: - Public

    /// Publishes changes made to the store.
    func changesPublisher(
    ) -> AnyPublisher<UserDefaultsStoreChange, Never> {
        changesSubject
            .eraseToAnyPublisher()
    }
}

extension UserDefaultsStore {

    /// Flag used to store preferences for new bookmarks.
    /// Bookmarks can be either private or public.
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

    /// Flag used to store preferences for reading option.
    /// Bookmarks can be set as "read later".
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

    /// Auth token required to perform the network requests.
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

    /// Uses to store the latest date when bookmarks where synchronized.
    /// Pinboard API's asks to check the date before making additional
    /// requests to retrieve all bookmarks.
    var lastSyncDate: Date? {
        get { userDefaults.object(forKey: Key.lastSyncDate) as? Date }
        set {
            userDefaults.setValue(
                newValue,
                forKey: Key.lastSyncDate
            )
            changesSubject.send(
                .lastSyncDate(lastSyncDate)
            )
        }
    }
}
