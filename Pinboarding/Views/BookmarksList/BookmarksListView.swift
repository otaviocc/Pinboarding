import CoreData
import SwiftUI

struct BookmarksListView: View {

    // MARK: - Properties

    @EnvironmentObject private var searchStore: SearchStore

    private var fetchRequest: FetchRequest<Bookmark>

    // MARK: - Life cycle

    init(
        viewModel: BookmarksListViewModel
    ) {
        self.fetchRequest = FetchRequest<Bookmark>(
            entity: Bookmark.entity(),
            sortDescriptors: [.makeSortByTimeDescending()],
            predicate: viewModel.predicate
        )
    }

    // MARK: - Public

    var body: some View {
        let bookmarks = fetchRequest
            .wrappedValue
            .filter(
                matching(
                    \.title,
                    with: searchStore.searchTerm
                )
            )

        List(bookmarks, id: \.self) { bookmark in
            BookmarkView(
                viewModel: BookmarkViewModel(
                    bookmark: bookmark
                )
            )
        }
    }
}

// MARK: - Private

private func matching(
    _ path: KeyPath<Bookmark, String>,
    with term: String
) -> (Bookmark) -> Bool {
    { bookmark in
        let title = bookmark[keyPath: path].lowercased()
        let searchTerm = term.lowercased()
        return title.contains(searchTerm) || term.isEmpty
    }
}

// MARK: - PreviewProvider

struct BookmarksList_Previews: PreviewProvider {

    static var previews: some View {
        let controller = Preview.makePersistenceController(
            populated: true
        )

        Group {
            BookmarksListView(viewModel: .tag(name: "sample1"))
                .frame(width: 320)
                .preferredColorScheme(.light)

            BookmarksListView(viewModel: .all)
                .frame(width: 320)
                .preferredColorScheme(.dark)
        }
        .environment(
            \.managedObjectContext,
            controller.container.viewContext
        )
    }
}
