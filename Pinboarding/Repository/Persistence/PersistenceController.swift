import Combine
import CoreData
import PinboardKit

struct PersistenceController: PersistenceControllerProtocol {

    // MARK: - Properties

    private let container: NSPersistentContainer
    private let eventsSubject = PassthroughSubject<PersistenceControllerEvent, Never>()

    // MARK: - Life cycle

    init(
        inMemory: Bool = false
    ) {
        self.container = NSPersistentContainer(
            name: "Pinboarding"
        )

        if inMemory {
            self.container.persistentStoreDescriptions.first?.url = URL(
                fileURLWithPath: "/dev/null"
            )
        }

        self.container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError(
                    "Something bad happened: \(error), \(error.userInfo)"
                )
            }
        }
    }

    // MARK: - Public

    func appendNewPosts(
        _ posts: [PostResponse]
    ) {
        var bookmarks: [Bookmark] = []

        posts.forEach { postResponse in
            do {
                let post = try Post.makePost(
                    from: postResponse,
                    in: container.viewContext
                )
                bookmarks.append(
                    .makeBookmark(from: post)
                )
            } catch {
                print("Something happened: \(error)")
            }

            eventsSubject.send(
                .newBookmarksAdded(bookmarks)
            )
        }
    }

    func allPostsPublisher() -> AnyPublisher<[Post], Never> {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.sortDescriptors = [
            .init(
                key: "time",
                ascending: false
            )
        ]

        return makePostsPublisher(
            request: request
        )
    }

    // MARK: - Private

    private func makePostsPublisher(
        request: NSFetchRequest<Post>
    ) -> AnyPublisher<[Post], Never> {
        container.viewContext
            .fetchPublisher(request: request)
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }
}
