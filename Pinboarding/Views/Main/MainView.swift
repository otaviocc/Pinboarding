import SwiftUI

struct MainView: View {

    // MARK: - Properties

    @EnvironmentObject var repository: PinboardRepository

    // MARK: - Public

    var body: some View {
        NavigationView {
            SidebarView(viewModel: SidebarViewModel())
            BookmarksView(viewModel: BookmarksViewModel(repository: repository))
        }
    }
}

// MARK: - PreviewProvider

//struct MainView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MainView()
//            .environmentObject(PinboardRepository.shared)
//    }
//}
