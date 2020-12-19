import SwiftUI

struct MainView: View {

    // MARK: - Public

    var body: some View {
        NavigationView {
            SidebarView(viewModel: SidebarViewModel())
            BookmarksView(viewModel: BookmarksViewModel())
        }
    }
}

// MARK: - PreviewProvider

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView()
    }
}
