import Foundation
import Combine

final class GeneralViewModel: ObservableObject {

    // MARK: - Properties

    @Published var isPrivate: Bool = true
    @Published var isToRead: Bool = false

    private let userDefaultsStore: UserDefaultsStore
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        userDefaultsStore: UserDefaultsStore
    ) {
        self.userDefaultsStore = userDefaultsStore
        self.isPrivate = userDefaultsStore.isPrivate
        self.isToRead = userDefaultsStore.isToRead

        $isPrivate
            .dropFirst()
            .assign(to: \.userDefaultsStore.isPrivate, on: self)
            .store(in: &cancellables)

        $isToRead
            .dropFirst()
            .assign(to: \.userDefaultsStore.isToRead, on: self)
            .store(in: &cancellables)
    }
}
