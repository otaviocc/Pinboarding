import SwiftUI
import MicroContainer

struct MainView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModelFactory: ViewModelFactory
    @State private var showAddBookmark = false

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
                OfflineView(
                    viewModel: viewModelFactory.makeOfflineViewModel()
                )

                RefreshView(
                    viewModel: viewModelFactory.makeRefreshViewModel()
                )

                AddView(
                    showAddBookmark: $showAddBookmark
                )
                .sheet(isPresented: $showAddBookmark) {
                    AddBookmarkView(
                        viewModel: viewModelFactory.makeAddBookmarkViewModel(),
                        isPresented: $showAddBookmark
                    )
                    .frame(width: 640)
                }
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
        .environmentObject(previewAppEnvironment.viewModelFactory)
        .environmentObject(previewAppEnvironment.settingsStore)
        .environmentObject(previewAppEnvironment.searchStore)
        .environmentObject(previewAppEnvironment.repository)
        .environment(
            \.managedObjectContext,
             previewAppEnvironment.persistenceService.container.viewContext
        )
    }
}
