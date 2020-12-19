import Foundation

@propertyWrapper struct UserDefault<T> {

    // MARK: - Properties

    private let key: String
    private let initialValue: T
    private let userDefaults: UserDefaults

    var wrappedValue: T {
        get { userDefaults.object(forKey: key) as? T ?? initialValue }
        set { userDefaults.set(newValue, forKey: key) }
    }

    // MARK: - Life cycle

    init(
        key: String,
        initialValue: T,
        userDefaults: UserDefaults = .standard
    ) {
        self.key = key
        self.initialValue = initialValue
        self.userDefaults = userDefaults
    }
}
