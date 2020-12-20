import Foundation
import Combine

final class GeneralViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isPrivate: Bool = true
    @Published var isToRead: Bool = false
    @Published var showPrivateIcon: Bool = true

    private var settingsStore: SettingsStoreProtocol
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Life cycle

    init(
        settingsStore: SettingsStoreProtocol = SettingsStore.shared
    ) {
        self.settingsStore = settingsStore
        self.isPrivate = settingsStore.isPrivate
        self.isToRead = settingsStore.isToRead
        self.showPrivateIcon = settingsStore.showPrivateIcon

        $isPrivate
            .dropFirst()
            .sink { self.settingsStore.isPrivate = $0 }
            .store(in: &cancellables)

        $isToRead
            .dropFirst()
            .sink { self.settingsStore.isToRead = $0 }
            .store(in: &cancellables)

        $showPrivateIcon
            .dropFirst()
            .sink { self.settingsStore.showPrivateIcon = $0 }
            .store(in: &cancellables)
    }
}
