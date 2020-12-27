import CoreData
import SwiftUI

struct BookmarksListView: View {

    // MARK: - Properties

    private let fetchRequest: FetchRequest<Bookmark>

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
        List(fetchRequest.wrappedValue, id: \.self) { bookmark in
            BookmarkView(
                viewModel: BookmarkViewModel(
                    bookmark: bookmark
                )
            )
        }
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
        }.environment(
            \.managedObjectContext,
            controller.container.viewContext
        )
    }
}
