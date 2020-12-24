import Combine
import Foundation
import PinboardKit

public class PinboardRepository: ObservableObject {

    // MARK: - Properties

    let persistenceController: PersistenceController
    let networkController: NetworkController

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        networkController: NetworkController,
        persistenceController: PersistenceController
    ) {
        self.networkController = networkController
        self.persistenceController = persistenceController
        self.networkController.updatesPublisher()
            .sink { posts in
                self.persistenceController.appendNewPosts(posts)
            }
            .store(in: &cancellables)
    }
}
