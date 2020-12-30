import Combine
import Foundation
import PinboardKit

public class PinboardRepository: ObservableObject {

    // MARK: - Properties

    let persistenceController: PersistenceController
    let networkController: NetworkController

    // MARK: - Life cycle

    init(
        networkController: NetworkController,
        persistenceController: PersistenceController
    ) {
        self.networkController = networkController
        self.persistenceController = persistenceController
    }
}
