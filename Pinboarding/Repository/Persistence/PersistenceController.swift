import Combine
import CoreData
import PinboardKit

struct PersistenceController {

    // MARK: - Properties

    let container: NSPersistentContainer

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    init(
        inMemory: Bool = false,
        updatesPublisher: AnyPublisher<[PostResponse], Never>
    ) {
        self.container = NSPersistentContainer(
            name: "Pinboarding"
        )

        if inMemory {
            self.container.persistentStoreDescriptions.first?.url = URL(
                fileURLWithPath: "/dev/null"
            )
        }

        self.container.loadPersistentStores { [container] _, _ in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }

        updatesPublisher
            .sink { [container] posts in
                posts.forEach { post in
                    do {
                        try Bookmark.makeBookmark(
                            from: post,
                            in: container.viewContext
                        )
                    } catch {
                        print("Something happened: \(error)")
                    }
                }
            }
            .store(in: &cancellables)
    }
}
