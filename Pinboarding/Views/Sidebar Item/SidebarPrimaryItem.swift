import Combine

enum SidebarPrimaryItem: String, CaseIterable {
    case all
    case `public`
    case `private`
    case unread

    // MARK: - Properties

    var iconName: String {
        switch self {
        case .all: return Icon.allBookmarks
        case .public: return Icon.publicBookmarks
        case .private: return Icon.privateBookmarks
        case .unread: return Icon.unreadBookmarks
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
