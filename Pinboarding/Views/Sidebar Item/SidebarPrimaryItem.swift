import Foundation
import Combine

enum SidebarPrimaryItem: String, CaseIterable {

    case all
    case `public`
    case `private`
    case unread
    case tags

    // MARK: - Properties

    var iconName: String {
        switch self {
        case .all: return "bookmark"
        case .public: return "person.2"
        case .private: return "lock"
        case .unread: return "envelope.badge"
        case .tags: return "tag"
        }
    }

    var title: String {
        rawValue.capitalized
    }
}
