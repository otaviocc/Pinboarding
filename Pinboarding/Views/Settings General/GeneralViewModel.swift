import Foundation
import Combine

final class GeneralViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isPrivate: Bool = true
    @Published var isToRead: Bool = false
    @Published var showPrivateIcon: Bool = true

    private let userDefaultsStore: UserDefaultsStoreStore
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        userDefaultsStore: UserDefaultsStoreStore
    ) {
        self.userDefaultsStore = userDefaultsStore
        self.isPrivate = userDefaultsStore.isPrivate
        self.isToRead = userDefaultsStore.isToRead
        self.showPrivateIcon = userDefaultsStore.showPrivateIcon

        $isPrivate
            .dropFirst()
            .assign(to: \.userDefaultsStore.isPrivate, on: self)
            .store(in: &cancellables)

        $isToRead
            .dropFirst()
            .assign(to: \.userDefaultsStore.isToRead, on: self)
            .store(in: &cancellables)

        $showPrivateIcon
            .dropFirst()
            .assign(to: \.userDefaultsStore.showPrivateIcon, on: self)
            .store(in: &cancellables)
    }
}
