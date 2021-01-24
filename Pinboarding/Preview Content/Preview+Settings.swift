import Foundation

extension Preview {

    /// User Defaults Store for SwiftUI Previews.
    static func makeSettingsStore(
    ) -> SettingsStore {
        let store = SettingsStore(
            userDefaults: makePreviewUserDefaults()
        )

        store.isPrivate = true
        store.isToRead = false

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
