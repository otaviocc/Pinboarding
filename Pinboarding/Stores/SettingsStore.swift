import Combine
import Foundation

final class SettingsStore: ObservableObject {

    // MARK: - Nested types

    private enum Key: String {
        case authToken
        case isPrivate
        case isToRead
    }

    // MARK: - Properties

    let objectWillChange = PassthroughSubject<Void, Never>()

    @UserDefault(key: Key.authToken.rawValue, initialValue: "") var authToken: String
    @UserDefault(key: Key.isPrivate.rawValue, initialValue: true) var isPrivate: Bool
    @UserDefault(key: Key.isToRead.rawValue, initialValue: false) var isToRead: Bool

    private var cancellable: AnyCancellable?
    private let notificationCenter: NotificationCenter

    // MARK: - Life cycle

    init(
        notificationCenter: NotificationCenter = .default
    ) {
        self.notificationCenter = notificationCenter
        self.cancellable = notificationCenter
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .receive(on: DispatchQueue.main)
            .subscribe(objectWillChange)
    }
}
