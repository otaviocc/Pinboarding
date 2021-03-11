import Combine

final class MyBookmarksSectionViewModel: ObservableObject {

    // MARK: - Properties

    let primaryItems: [SidebarPrimaryItem]

    // MARK: - Life cycle

    init(
    ) {
        self.primaryItems = SidebarPrimaryItem.allCases
    }
}
