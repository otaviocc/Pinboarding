import Foundation
import Combine

final class GeneralViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isPrivate: Bool = true
    @Published var isToRead: Bool = false

    private let settingsStore: SettingsStore
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        settingsStore: SettingsStore
    ) {
        self.settingsStore = settingsStore
        self.isPrivate = settingsStore.isPrivate
        self.isToRead = settingsStore.isToRead

        $isPrivate
            .dropFirst()
            .assign(to: \.settingsStore.isPrivate, on: self)
            .store(in: &cancellables)

        $isToRead
            .dropFirst()
            .assign(to: \.settingsStore.isToRead, on: self)
            .store(in: &cancellables)
    }
}
