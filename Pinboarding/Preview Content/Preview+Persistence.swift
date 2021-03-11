import Combine
import CoreData
import PinboardKit

extension Preview {

    /// In memory Persistence Controller for SwiftUI Previews.
    static func makePersistenceController(
        populated: Bool = false
    ) -> PersistenceController {
        let controller = PersistenceController(
            inMemory: true
        )

        if populated {
            makeBookmarks(
                count: 3,
                in: controller.container.viewContext
            )

            makeTags(
                count: 5,
                in: controller.container.viewContext
            )
        }

        return controller
    }

    /// Generates (and adds do Core Data) bookmarks
    /// for SwiftUI Previews.
    static func makeBookmarks(
        count: Int,
        in context: NSManagedObjectContext
    ) {
        for i in 0..<count {
            let bookmark = Bookmark(context: context)
            bookmark.abstract = "Nulla purus urna, bibendum nec purus."
            bookmark.href = "http://fake.url.com/toto"
            bookmark.id = String(i)
            bookmark.meta = "meta"
            bookmark.isShared = false
            bookmark.time = Date()
            bookmark.title = "Lorem Ipsum \(i)"
            bookmark.isToRead = false
            bookmark.tags = []

            let tag = Tag(context: context)
            tag.name = "sample\(i)"
            bookmark.tags = NSSet(array: [tag])

            try? context.save()
        }
    }

    /// Generates (and adds do Core Data) tags
    /// for SwiftUI Previews.
    static func makeTags(
        count: Int,
        in context: NSManagedObjectContext
    ) {
        for i in 0..<count {
            let tag = Tag(context: context)
            tag.name = "tag\(i)"
            tag.bookmarks = []
            try? context.save()
        }
    }

    /// Publishes bookmarks updates for SwiftUI
    /// Previews.
    static func makeAllBookmarksUpdatesPublisher(
    ) -> AnyPublisher<[PostResponse], Never> {
        Just([])
            .eraseToAnyPublisher()
    }
}
