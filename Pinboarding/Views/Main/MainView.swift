import SwiftUI

struct MainView: View {

    // MARK: - Properties

    @EnvironmentObject private var repository: PinboardRepository
    @EnvironmentObject private var settingsStore: SettingsStore
    @State private var showAddBookmark = false

    // MARK: - Public

    var body: some View {
        NavigationView {
            SidebarView(
                viewModel: SidebarViewModel(
                    networkActivityPublisher: repository.networkActivityPublisher()
                )
            )

            BookmarksView(viewModel: .all)
        }
        .toolbar {
            ToolbarItemGroup {
                RefreshView(
                    viewModel: RefreshViewModel(
                        repository: repository
                    )
                )
                .help("Force refresh")

                Button(
                    action: { showAddBookmark.toggle() },
                    label: { Image(systemName: Icon.addBookmark) }
                )
                .help("Add a new bookmark")
                .sheet(isPresented: $showAddBookmark) {
                    AddBookmarkView(
                        viewModel: AddBookmarkViewModel(
                            repository: repository,
                            settingsStore: settingsStore
                        ),
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
        .environmentObject(previewAppEnvironment.settingsStore)
        .environmentObject(previewAppEnvironment.searchStore)
        .environmentObject(previewAppEnvironment.repository)
        .environment(
            \.managedObjectContext,
            previewAppEnvironment.persistenceService.container.viewContext
        )
    }
}
