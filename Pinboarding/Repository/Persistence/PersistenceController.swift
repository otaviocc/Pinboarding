import CoreData
import PinboardKit

struct PersistenceController {

    // MARK: - Properties

    let container: NSPersistentContainer

    // MARK: - Life cycle

    init(
        inMemory: Bool = false
    ) {
        container = NSPersistentContainer(
            name: "Pinboarding"
        )

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(
                fileURLWithPath: "/dev/null"
            )
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError(
                    "Something bad happened: \(error), \(error.userInfo)"
                )
            }
        }
    }
}
