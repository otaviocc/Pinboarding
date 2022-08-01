import Combine

enum SidebarPrimaryItem: String, CaseIterable {
    case all
    case `public`
    case `private`
    case unread

    // MARK: - Properties

    var iconName: String {
        switch self {
        case .all: return Asset.Bookmark.all
        case .public: return Asset.Bookmark.public
        case .private: return Asset.Bookmark.private
        case .unread: return Asset.Bookmark.unread
        }
    }

    var title: String {
        rawValue.capitalized
    }

    var listType: BookmarksListViewModel {
        switch self {
        case .all: return .all
        case .public: return .public
        case .private: return .private
        case .unread: return .unread
        }
    }
}
