import Foundation
import CoreData

extension Post {

    // MARK: - Properties

    @NSManaged public var abstract: String
    @NSManaged public var href: String
    @NSManaged public var id: String
    @NSManaged public var meta: String
    @NSManaged public var isShared: Bool
    @NSManaged public var time: Date
    @NSManaged public var title: String
    @NSManaged public var isToRead: Bool
    @NSManaged public var tags: NSSet


    // MARK: - Public

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Post> {
        NSFetchRequest<Post>(
            entityName: "Post"
        )
    }

    // MARK: - Relationships

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension Post: Identifiable { }
