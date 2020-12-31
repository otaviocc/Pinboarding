import Foundation

enum UserDefaultsStoreChange {
    case authToken(_ token: String)
    case isPrivate(_ value: Bool)
    case isToRead(_ value: Bool)
    case showPrivateIcon(_ value: Bool)
    case lastSyncDate(_ date: Date?)
}
