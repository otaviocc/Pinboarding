import SwiftUI

struct BookmarksView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: BookmarksViewModel

    // MARK: - Life cycle

    init(
        viewModel: BookmarksViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        List(viewModel.bookmarks, id: \.hash) { bookmark in
            BookmarkView(
                viewModel: BookmarkViewModel(bookmark: bookmark)
            )
        }
    }
}

// MARK: - PreviewProvider

struct BookmarksView_Previews: PreviewProvider {

    static var previews: some View {
        BookmarksView(viewModel: BookmarksViewModel())
    }
}
