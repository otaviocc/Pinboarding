import Foundation
import CoreData

extension Tag {

    // MARK: - Properties

    @NSManaged public var name: String
    @NSManaged public var bookmarks: NSSet

    // MARK: - Public

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    // MARK: - Relationships

    @objc(addBookmarkObject:)
    @NSManaged public func addToBookmarks(_ value: Bookmark)

    @objc(removeBookmarkObject:)
    @NSManaged public func removeFromBookmarks(_ value: Bookmark)

    @objc(addBookmark:)
    @NSManaged public func addToBookmarks(_ values: NSSet)

    @objc(removeBookmark:)
    @NSManaged public func removeFromBookmarks(_ values: NSSet)
}

extension Tag: Identifiable { }
