import Foundation

enum SettingsStoreChange {
    case authToken(_ token: String)
    case isPrivate(_ value: Bool)
    case isToRead(_ value: Bool)
    case showPrivateIcon(_ value: Bool)
}
