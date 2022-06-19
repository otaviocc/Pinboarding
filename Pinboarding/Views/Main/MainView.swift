import Combine
import SwiftUI
import MicroContainer

struct MainView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModelFactory: ViewModelFactory
    @ObservedObject private var viewModel: MainViewModel

    // MARK: - Life cycle

    init(
        viewModel: MainViewModel
    ) {
        self.viewModel = viewModel
    }

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
                    showAddBookmark: $viewModel.showAddBookmark
                )
                .sheet(isPresented: $viewModel.showAddBookmark) {
                    AddBookmarkView(
                        viewModel: viewModelFactory.makeAddBookmarkViewModel(),
                        isPresented: $viewModel.showAddBookmark
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
            MainView(viewModel: .init())
                .preferredColorScheme(.light)

            MainView(viewModel: .init())
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
