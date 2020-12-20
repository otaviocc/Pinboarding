import Combine
import Foundation

final class SettingsStore: ObservableObject {

    // MARK: - Nested types

    private enum Key: String {
        case settingsAuthToken
        case settingsIsPrivate
        case settingsIsToRead
    }

    // MARK: - Properties

    let changesSubject = PassthroughSubject<Void, Never>()

    @UserDefaultWrapper(Key.settingsAuthToken.rawValue, initialValue: "") var authToken
    @UserDefaultWrapper(Key.settingsIsPrivate.rawValue, initialValue: true) var isPrivate
    @UserDefaultWrapper(Key.settingsIsToRead.rawValue, initialValue: false) var isToRead

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
            .subscribe(changesSubject)
    }
}
