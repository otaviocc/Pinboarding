import Foundation

@propertyWrapper struct UserDefaultWrapper<T> {

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
        _ key: String,
        initialValue: T,
        userDefaults: UserDefaults = .standard
    ) {
        self.initialValue = initialValue
        self.key = key
        self.userDefaults = userDefaults
    }
}
