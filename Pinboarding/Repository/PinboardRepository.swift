import Combine
import Foundation
import PinboardKit

public class PinboardRepository: ObservableObject {

    // MARK: - Properties

    let persistenceController: PersistenceController
    let networkController: NetworkController

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    convenience init() {
        self.init(
            networkController: NetworkController(
                settingsController: .shared
            ),
            persistenceController: PersistenceController(
                inMemory: false
            )
        )

        self.synchronizeBookmarksContinuously()
    }

    private init(
        networkController: NetworkController,
        persistenceController: PersistenceController
    ) {
        self.networkController = networkController
        self.persistenceController = persistenceController
    }

    // MARK: - Private

    private func synchronizeBookmarksContinuously() {
        networkController.updatesPublisher()
            .sink { [weak self] posts in
                self?.persistenceController.appendNewPosts(posts)
            }
            .store(in: &cancellables)
    }
}
