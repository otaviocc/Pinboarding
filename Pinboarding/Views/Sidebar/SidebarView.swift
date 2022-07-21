import SwiftUI

struct SidebarView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: SidebarViewModel
    @EnvironmentObject private var viewModelFactory: ViewModelFactory

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
                    viewModel: viewModelFactory.makeMyBookmarksSectionViewModel()
                )
                TagsSectionView()
            }
            .listStyle(SidebarListStyle())

            Spacer()

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
            }
        }
    }
}

// MARK: - PreviewProvider

struct SidebarView_Previews: PreviewProvider {

    static var previews: some View {
        let loadingPublisher = Preview.makeNetworkActivityPublisher(
            loading: true
        )

        let notLoadingPublisher = Preview.makeNetworkActivityPublisher(
            loading: false
        )

        Group {
            SidebarView(
                viewModel: .init(
                    networkActivityPublisher: notLoadingPublisher,
                    searchStore: previewAppEnvironment.searchStore
                )
            )
            .preferredColorScheme(.light)
            .frame(width: 200)

            SidebarView(
                viewModel: .init(
                    networkActivityPublisher: loadingPublisher,
                    searchStore: previewAppEnvironment.searchStore
                )
            )
            .preferredColorScheme(.dark)
            .frame(width: 200)
        }
        .withPreviewDependencies()
    }
}
