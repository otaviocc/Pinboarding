import Foundation
import CoreData

extension Post {

    // MARK: - Properties

    @NSManaged public var href: String
    @NSManaged public var title: String
    @NSManaged public var extended: String
    @NSManaged public var meta: String
    @NSManaged public var id: String
    @NSManaged public var shared: String
    @NSManaged public var time: Date
    @NSManaged public var toread: String
    @NSManaged public var tags: String

    // MARK: - Public

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }
}

extension Post: Identifiable { }
