import SwiftUI

struct MainView: View {

    // MARK: - Public

    var body: some View {
        NavigationView {
            SidebarView(viewModel: SidebarViewModel())
            BookmarksView()
        }
    }
}
