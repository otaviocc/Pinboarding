import SwiftUI

struct MainView: View {

    // MARK: - Properties

    @EnvironmentObject var repository: PinboardRepository

    // MARK: - Public

    var body: some View {
        NavigationView {
            SidebarView(viewModel: SidebarViewModel())
            BookmarksView()
        }
    }
}
