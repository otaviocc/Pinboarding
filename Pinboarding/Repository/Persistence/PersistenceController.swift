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
        allBookmarksUpdatesPublisher: AnyPublisher<[PostResponse], Never>
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
            container.viewContext.mergePolicy =
                NSMergeByPropertyObjectTrumpMergePolicy
        }

        #warning("move logic to repository")
        allBookmarksUpdatesPublisher
            .sink { [self] posts in
                self.addNewBookmarks(posts)
                self.removeDeletedBookmarks(posts)
                self.removeUnusedTags()
            }
            .store(in: &cancellables)
    }

    // MARK: - Public

    /// Store a new bookmark on Core Data.
    func addNewBookmarkPublisher(
        _ post: PostResponse
    ) {
        do {
            try Bookmark.makeBookmark(
                from: post,
                in: container.viewContext
            )
        } catch {
            print("Something happened: \(error)")
        }
    }

    // MARK: - Private

    /// Stores all bookmarks on Core Data.
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

    /// Remove bookmarks from Core Data if deleted from
    /// Pinboard.
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

    /// Remove tags without associated bookmarks.
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

    /// Perform the removal from Core Data.
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

            try container.viewContext.save()
        } catch {
            print("Something happened: \(error)")
        }
    }
}
