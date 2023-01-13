import Foundation

enum BookmarksListViewModel: Hashable {
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

    // MARK: - Life cycle

    init(
        item: NavigationDestination
    ) {
        switch item {
        case .all: self = .all
        case .public: self = .public
        case .private: self = .private
        case .unread: self = .unread
        case .tag(let name): self = .tag(name: name)
        }
    }
}
