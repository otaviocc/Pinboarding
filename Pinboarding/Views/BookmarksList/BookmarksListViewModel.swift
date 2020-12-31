import Foundation

enum BookmarksListViewModel {

    case all
    case `public`
    case `private`
    case unread
    case tag(name: String)

    // MARK: - Properties

    var predicate: NSPredicate? {
        switch self {
        case .all:
            return nil
        case .public:
            return NSPredicate(
                format: "isShared == true"
            )
        case .private:
            return NSPredicate(
                format: "isShared == false"
            )
        case .unread:
            return NSPredicate(
                format: "isToRead == true"
            )
        case .tag(let tagName):
            return NSPredicate(
                format: "ANY tags.name = %@",
                tagName
            )
        }
    }
}
