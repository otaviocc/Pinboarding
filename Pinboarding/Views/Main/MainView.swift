import SwiftUI
import MicroContainer

struct MainView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModelFactory: ViewModelFactory
    @Environment(\.openURL) var openURL

    // MARK: - Public

    var body: some View {
        NavigationView {
            SidebarView(
                viewModel: viewModelFactory.makeSidebarViewModel()
            )

            BookmarksView(viewModel: .all)
        }
        .toolbar {
            ToolbarItemGroup {
                RefreshView(
                    viewModel: viewModelFactory.makeRefreshViewModel()
                )
                .help("Force refresh")

                Button(
                    action: {
                        if let url = URL(string: "pinboarding://addbookmark") {
                            openURL(url)
                        }
                    },
                    label: { Image(systemName: Icon.addBookmark) }
                )
                .help("Add a new bookmark")
            }
        }
    }
}

// MARK: - PreviewProvider

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            MainView()
                .preferredColorScheme(.light)

            MainView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(previewAppEnvironment.settingsStore)
        .environmentObject(previewAppEnvironment.searchStore)
        .environmentObject(previewAppEnvironment.repository)
        .environment(
            \.managedObjectContext,
            previewAppEnvironment.persistenceService.container.viewContext
        )
    }
}
