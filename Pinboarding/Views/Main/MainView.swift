import SwiftUI

struct MainView: View {

    @EnvironmentObject var repository: PinboardRepository

    // MARK: - Public

    var body: some View {
        NavigationView {
            SidebarView(
                viewModel: SidebarViewModel(
                    networkActivityPublisher: repository.networkController.eventPublisher()
                )
            )

            BookmarksView(viewModel: .all)
        }
    }
}

// MARK: - PreviewProvider

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        let userDefaultsStore = Preview.makeUserDefaultsStore()
        let controller = Preview.makePersistenceController(
            populated: true
        )

        Group {
            MainView()
                .preferredColorScheme(.light)

            MainView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(userDefaultsStore)
        .environment(
            \.managedObjectContext,
            controller.container.viewContext
        )
    }
}
