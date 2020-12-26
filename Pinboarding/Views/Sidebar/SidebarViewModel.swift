import Foundation
import Combine

final class SidebarViewModel: ObservableObject {

    // MARK: - Properties

    let primaryItems: [SidebarPrimaryItem]

    // MARK: - Life cycle

    init(
    ) {
        self.primaryItems = SidebarPrimaryItem.allCases
    }
}
