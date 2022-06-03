import SwiftUI

struct BookmarksView: View {

    // MARK: - Properties

    @Environment(\.managedObjectContext)
    private var viewContext

    private let viewModel: BookmarksListViewModel

    // MARK: - Life cycle

    init(
        viewModel: BookmarksListViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        BookmarksListView(viewModel: viewModel)
    }
}

// MARK: - PreviewProvider

struct BookmarksView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            BookmarksView(viewModel: .all)
                .preferredColorScheme(.light)
                .frame(width: 320)
            BookmarksView(viewModel: .all)
                .preferredColorScheme(.dark)
                .frame(width: 320)
        }
        .environmentObject(previewAppEnvironment.searchStore)
        .environment(
            \.managedObjectContext,
            previewAppEnvironment.persistenceService.container.viewContext
        )
    }
}
