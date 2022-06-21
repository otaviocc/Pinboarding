import Combine
import Foundation

final class SettingsStore {

    // MARK: - Nested types

    private enum Key {
        static let isPrivate = "settingsIsPrivate"
        static let isToRead = "settingsIsToRead"
        static let lastSyncDate = "syncLastUpdate"
    }

    // MARK: - Properties

    private let userDefaults: UserDefaults
    private let changesSubject =
        PassthroughSubject<SettingsStoreChange, Never>()

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

    // MARK: - Life cycle

    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }

    // MARK: - Public

    /// Publishes changes made to the store.
    func changesPublisher(
    ) -> AnyPublisher<SettingsStoreChange, Never> {
        changesSubject
            .eraseToAnyPublisher()
    }
}
