enum NavigationDestination: Hashable {
    case all
    case `public`
    case `private`
    case unread
    case tag(name: String)

    // MARK: - Life cycle

    init(
        item: SidebarPrimaryItem
    ) {
        switch item {
        case .all: self = .all
        case .public: self = .public
        case .private: self = .private
        case .unread: self = .unread
        }
    }
}
