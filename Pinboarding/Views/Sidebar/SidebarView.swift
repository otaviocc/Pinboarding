import SwiftUI

struct SidebarView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: SidebarViewModel

    // MARK: - Life cycle

    init(
        viewModel: SidebarViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        VStack {
            List {
                MyBookmarksSectionView(
                    viewModel: MyBookmarksSectionViewModel()
                )
                TagsSectionView()
            }
            .listStyle(SidebarListStyle())

            Spacer()

            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}

// MARK: - PreviewProvider

struct SidebarView_Previews: PreviewProvider {

    static var previews: some View {
        let controller = Preview.makePersistenceController(
            populated: true
        )

        let loadingPublisher = Preview.makeNetworkActivityPublisher(loading: true)
        let notLoadingPublisher = Preview.makeNetworkActivityPublisher(loading: false)

        Group {
            SidebarView(
                viewModel: SidebarViewModel(
                    networkActivityPublisher: notLoadingPublisher
                ))
                .preferredColorScheme(.light)
                .frame(width: 200)

            SidebarView(
                viewModel: SidebarViewModel(
                    networkActivityPublisher: loadingPublisher
                ))
                .preferredColorScheme(.dark)
                .frame(width: 200)
        }
        .environment(
            \.managedObjectContext,
            controller.container.viewContext
        )
    }
}
