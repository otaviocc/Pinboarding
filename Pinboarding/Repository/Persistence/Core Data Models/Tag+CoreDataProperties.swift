import Foundation
import CoreData

extension Tag {

    // MARK: - Properties

    @NSManaged public var name: String
    @NSManaged public var posts: NSSet

    // MARK: - Public

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    // MARK: - Relationships

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: Post)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: Post)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)
}

extension Tag: Identifiable { }
