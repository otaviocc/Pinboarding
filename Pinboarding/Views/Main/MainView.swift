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

// MARK: - PreviewProvider

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        let controller = Preview.makePersistenceControllerInMemory()
        let settingsStore = Preview.makeSettingsStore()

        Group {
            MainView()
                .preferredColorScheme(.light)

            MainView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(settingsStore)
        .environment(
            \.managedObjectContext,
            controller.container.viewContext
        )
    }
}
