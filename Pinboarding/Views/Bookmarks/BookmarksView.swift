import SwiftUI

struct BookmarksView: View {

    // MARK: - Properties

    @Environment(\.managedObjectContext)
    var viewContext

    @FetchRequest(entity: Post.entity(), sortDescriptors: [.makeSortByTimeAscending()])
    var posts: FetchedResults<Post>

    // MARK: - Public

    var body: some View {
        List {
            ForEach(posts, id: \.hash) { post in
                BookmarkView(
                    viewModel: BookmarkViewModel(
                        bookmark: post
                    )
                )
            }
        }
    }
}
