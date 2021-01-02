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

    func addBookmark(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: Bool = false,
        shared: Bool = false,
        toread: Bool = false
    ) -> AnyPublisher<Void, Error> {
        networkController.addBookmarkPublisher(
            url: url,
            description: description,
            extended: extended,
            tags: tags,
            date: date,
            replace: replace.stringValue,
            shared: shared.stringValue,
            toread: toread.stringValue
        )
        .map(self.persistenceController.addNewBookmarkPublisher)
        .eraseToAnyPublisher()
    }
}
