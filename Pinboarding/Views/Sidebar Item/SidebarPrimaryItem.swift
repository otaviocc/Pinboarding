import Foundation
import Combine

enum SidebarPrimaryItem: String, CaseIterable {

    case all
    case `public`
    case `private`
    case unread

    // MARK: - Properties

    var iconName: String {
        switch self {
        case .all: return "bookmark"
        case .public: return "person.2"
        case .private: return "lock"
        case .unread: return "envelope.badge"
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
