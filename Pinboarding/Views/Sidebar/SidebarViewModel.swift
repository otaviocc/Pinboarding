import Foundation
import Combine

final class SidebarViewModel: ObservableObject {

    // MARK: - Properties

    let items: [SidebarItemViewModel]

    // MARK: - Life cycle

    init(
    ) {
        self.items =  SidebarItemViewModel.allCases
    }
}
