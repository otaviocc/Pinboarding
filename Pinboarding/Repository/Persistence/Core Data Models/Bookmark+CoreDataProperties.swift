import Foundation
import CoreData

public extension Bookmark {

    // MARK: - Properties

    @NSManaged var abstract: String
    @NSManaged var href: String
    @NSManaged var id: String
    @NSManaged var meta: String
    @NSManaged var isShared: Bool
    @NSManaged var time: Date
    @NSManaged var title: String
    @NSManaged var isToRead: Bool
    @NSManaged var tags: NSSet

    // MARK: - Public

    @nonobjc
    static func fetchRequest(
    ) -> NSFetchRequest<Bookmark> {
        NSFetchRequest<Bookmark>(
            entityName: "Bookmark"
        )
    }

    // MARK: - Relationships

    @objc(addTagsObject:)
    @NSManaged func addToTags(
        _ value: Tag
    )

    @objc(removeTagsObject:)
    @NSManaged func removeFromTags(
        _ value: Tag
    )

    @objc(addTags:)
    @NSManaged func addToTags(
        _ values: NSSet
    )

    @objc(removeTags:)
    @NSManaged func removeFromTags(
        _ values: NSSet
    )
}

extension Bookmark: Identifiable { }
