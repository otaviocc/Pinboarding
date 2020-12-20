import Combine

protocol SettingsStoreProtocol {
    var isPrivate: Bool { get set }
    var isToRead: Bool { get set }
    var authToken: String { get set }
    var showPrivateIcon: Bool { get set }

    func changes() -> AnyPublisher<SettingsStoreChange, Never>
}
