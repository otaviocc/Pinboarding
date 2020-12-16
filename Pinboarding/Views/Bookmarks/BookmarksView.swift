import SwiftUI

struct BookmarksView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: BookmarksViewModel

    // MARK: - Life cycle

    var body: some View {
        Text("hello, world")
    }
}

// MARK: - PreviewProvider

struct BookmarksView_Previews: PreviewProvider {

    static var previews: some View {
        BookmarksView(viewModel: BookmarksViewModel())
    }
}
