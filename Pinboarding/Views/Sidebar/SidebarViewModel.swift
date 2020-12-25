import Foundation
import Combine

final class SidebarViewModel: ObservableObject {

    // MARK: - Properties

    let items: [SidebarPrimaryItem]

    // MARK: - Life cycle

    init(
    ) {
        self.items =  SidebarPrimaryItem.allCases
    }
}
