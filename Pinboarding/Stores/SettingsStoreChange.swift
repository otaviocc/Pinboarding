import Foundation

enum SettingsStoreChange {
    case isPrivate(_ value: Bool)
    case isToRead(_ value: Bool)
    case lastSyncDate(_ date: Date?)
}
