import Combine
import SwiftUI
import MicroContainer

struct MainView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModelFactory: ViewModelFactory
    @ObservedObject private var viewModel: MainViewModel
    @State private var searchExpanded = false

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
            .frame(minWidth: 160, idealWidth: 160)

            BookmarksView(
                viewModel: .all
            )
            .frame(minWidth: 320, idealWidth: 640)
        }
        .toolbar {
            ToolbarItemGroup {
                SearchBarView()
            }

            ToolbarItemGroup {
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
        .withPreviewDependencies()
    }
}
