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
            ForEach(bookmarks, id: \.id) { post in
                BookmarkView(
                    viewModel: BookmarkViewModel(
                        bookmark: post
                    )
                )
            }
        }
    }
}
