import Foundation

extension Preview {

    static func makeUserDefaultsStore(
    ) -> UserDefaultsStoreStore {
        let store = UserDefaultsStoreStore(
            userDefaults: makePreviewUserDefaults()
        )

        store.authToken = "mock token"
        store.isPrivate = true
        store.isToRead = false
        store.showPrivateIcon = true

        return store
    }

    static func makePreviewUserDefaults(
    ) -> UserDefaults {
        UserDefaults(
            suiteName: "Preview"
        )!
    }
}
