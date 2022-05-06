import CoreData
import MicroPinboard

extension Bookmark {

    /// Converts PostResponses to Bookmarks, adding
    /// them to Core Data.
    @discardableResult
    static func makeBookmark(
        from postResponse: PostResponse,
        in context: NSManagedObjectContext
    ) throws -> Bookmark {
        let bookmark = Bookmark(
            context: context
        )

        bookmark.href = postResponse.href
        bookmark.title = postResponse.description
        bookmark.abstract = postResponse.extended
        bookmark.meta = postResponse.meta
        bookmark.time = postResponse.time
        bookmark.isShared = postResponse.shared.booleanValue
        bookmark.isToRead = postResponse.toread.booleanValue
        bookmark.id = postResponse.hash

        let tags = postResponse.tags
            .split(separator: " ")
            .map(String.init)
            .map { name -> Tag in
                let tag = Tag(context: context)
                tag.name = name.lowercased()
                return tag
            }
        bookmark.tags = NSSet(array: tags)

        try context.save()

        return bookmark
    }
}
