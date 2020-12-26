import SwiftUI

struct BookmarksView: View {

    // MARK: - Properties

    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(entity: Bookmark.entity(), sortDescriptors: [.makeSortByTimeDescending()])
    private var bookmarks: FetchedResults<Bookmark>

    // MARK: - Public

    var body: some View {
        List {
            ForEach(bookmarks, id: \.id) { bookmark in
                BookmarkView(
                    viewModel: BookmarkViewModel(
                        bookmark: bookmark
                    )
                )
            }
        }
    }
}

// MARK: - PreviewProvider

struct BookmarksView_Previews: PreviewProvider {

    static var previews: some View {
        let controller = Preview.makePersistenceController(
            populated: true
        )

        Group {
            BookmarksView()
                .preferredColorScheme(.light)
                .frame(width: 320)
            BookmarksView()
                .preferredColorScheme(.dark)
                .frame(width: 320)
        }.environment(
            \.managedObjectContext,
            controller.container.viewContext
        )
    }
}
