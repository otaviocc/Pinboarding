import Foundation

extension Preview {

    /// User Defaults Store for SwiftUI Previews.
    static func makeSettingsStore(
        isPrivate: Bool = true,
        isToRead: Bool = false,
        showMicroBlog: Bool = true
    ) -> SettingsStore {
        let store = SettingsStore(
            userDefaults: makePreviewUserDefaults()
        )

        store.isPrivate = isPrivate
        store.isToRead = isToRead
        store.showMicroBlog = showMicroBlog

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
