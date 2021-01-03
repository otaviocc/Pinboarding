import SwiftUI

struct MainView: View {

    // MARK: - Properties

    @EnvironmentObject private var repository: PinboardRepository
    @EnvironmentObject private var userDefaultsStore: UserDefaultsStore
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
                Button(
                    action: { showAddBookmark.toggle() },
                    label: { Image(systemName: "plus") }
                )
                .help("Add a new bookmark")
            }
        }.sheet(isPresented: $showAddBookmark) {
            AddBookmarkView(
                viewModel: AddBookmarkViewModel(
                    repository: repository,
                    userDefaultsStore: userDefaultsStore
                ),
                isPresented: $showAddBookmark
            )
            .frame(minWidth: 640, minHeight: 480)
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
