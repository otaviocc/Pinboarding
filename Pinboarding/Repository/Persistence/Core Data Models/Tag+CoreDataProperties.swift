import CoreData

public extension Tag {

    // MARK: - Properties

    @NSManaged var name: String
    @NSManaged var bookmarks: NSSet

    // MARK: - Public

    @nonobjc
    static func fetchRequest(
    ) -> NSFetchRequest<Tag> {
        NSFetchRequest<Tag>(
            entityName: "Tag"
        )
    }

    // MARK: - Relationships

    @objc(addBookmarkObject:)
    @NSManaged func addToBookmarks(
        _ value: Bookmark
    )

    @objc(removeBookmarkObject:)
    @NSManaged func removeFromBookmarks(
        _ value: Bookmark
    )

    @objc(addBookmark:)
    @NSManaged func addToBookmarks(
        _ values: NSSet
    )

    @objc(removeBookmark:)
    @NSManaged func removeFromBookmarks(
        _ values: NSSet
    )
}

extension Tag: Identifiable { }
