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

        // Adds new bookmarks to Core Data
        updatesPublisher
            .sink { [self] posts in
                self.addNewBookmarks(posts)
                self.removeDeletedBookmarks(posts)
                self.removeUnusedTags()
            }
            .store(in: &cancellables)
    }

    // MARK: - Private

    private func addNewBookmarks(
        _ posts: [PostResponse]
    ) {
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

    private func removeDeletedBookmarks(
        _ posts: [PostResponse]
    ) {
        let request = NSFetchRequest<Bookmark>(
            entityName: "Bookmark"
        )

        request.predicate = NSPredicate(
            format: "NOT id IN %@",
            posts.map { $0.hash }
        )

        removeManagedObject(
            fetchRequest: request
        )
    }

    private func removeUnusedTags(
    ) {
        let request = NSFetchRequest<Tag>(
            entityName: "Tag"
        )

        request.predicate = NSPredicate(
            format: "bookmarks.@count == 0"
        )

        removeManagedObject(
            fetchRequest: request
        )
    }

    private func removeManagedObject<Object>(
        fetchRequest: NSFetchRequest<Object>
    ) where Object: NSManagedObject {
        do {
            let objectsToRemove = try container.viewContext.fetch(
                fetchRequest
            ) as [Object]

            for object in objectsToRemove {
                container.viewContext.delete(object)
            }
        } catch {
            print("Something happened: \(error)")
        }
    }
}
