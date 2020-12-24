import Foundation
import Combine

final class GeneralViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isPrivate: Bool = true
    @Published var isToRead: Bool = false
    @Published var showPrivateIcon: Bool = true

    private var settingsStore: SettingsStore
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        settingsStore: SettingsStore
    ) {
        self.settingsStore = settingsStore
        self.isPrivate = settingsStore.isPrivate
        self.isToRead = settingsStore.isToRead
        self.showPrivateIcon = settingsStore.showPrivateIcon

        $isPrivate
            .dropFirst()
            .assign(to: \.settingsStore.isPrivate, on: self)
            .store(in: &cancellables)

        $isToRead
            .dropFirst()
            .assign(to: \.settingsStore.isToRead, on: self)
            .store(in: &cancellables)

        $showPrivateIcon
            .dropFirst()
            .assign(to: \.settingsStore.showPrivateIcon, on: self)
            .store(in: &cancellables)
    }
}
