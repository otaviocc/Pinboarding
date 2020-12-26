import Foundation
import CoreData

extension Preview {

    // MARK: - Double

    static func makePersistenceControllerInMemory(
    ) -> PersistenceController {
        let controller = PersistenceController(
            inMemory: true
        )

        makeBookmarks(
            count: 3,
            in: controller.container.viewContext
        )

        makeTags(
            count: 5,
            in: controller.container.viewContext
        )

        return controller
    }

    // MARK: - Private

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
            bookmark.isToRead  = false
            bookmark.tags = []

            let tag = Tag(context: context)
            tag.name = "sample"
            bookmark.tags = NSSet(array: [tag])

            try? context.save()
        }
    }

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
}
