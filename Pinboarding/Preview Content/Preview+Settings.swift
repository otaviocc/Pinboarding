import Foundation

extension Preview {

    /// User Defaults Store for SwiftUI Previews.
    static func makeUserDefaultsStore(
    ) -> UserDefaultsStore {
        let store = UserDefaultsStore(
            userDefaults: makePreviewUserDefaults()
        )

        store.authToken = "mock token"
        store.isPrivate = true
        store.isToRead = false
        store.showPrivateIcon = true

        return store
    }

    /// User Defaults for SwiftUI Previews.
    /// It has a different Suite Name so it doesn't
    /// conflict with the Standard one.
    static func makePreviewUserDefaults(
    ) -> UserDefaults {
        UserDefaults(
            suiteName: "Preview"
        )!
    }
}
