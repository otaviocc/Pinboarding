import Foundation
import Combine

final class GeneralViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isPrivate: Bool = true {
        didSet { settingsStore.isPrivate = isPrivate }
    }

    @Published var isToRead: Bool = false {
        didSet { settingsStore.isToRead = isToRead }
    }

    private let settingsStore: SettingsStore

    // MARK: - Life cycle

    init(
        settingsStore: SettingsStore = SettingsStore()
    ) {
        self.settingsStore = settingsStore
        self.isPrivate = settingsStore.isPrivate
        self.isToRead = settingsStore.isToRead
    }
}
