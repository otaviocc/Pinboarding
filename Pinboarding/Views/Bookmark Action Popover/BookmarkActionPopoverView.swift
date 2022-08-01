import SwiftUI

struct BookmarkActionPopoverView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: BookmarkActionPopoverViewModel

    // MARK: - Life cycle

    init(
        viewModel: BookmarkActionPopoverViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            QRCodeButton(
                url: viewModel.url
            )

            SafariButton(
                url: viewModel.url
            )

            ShareButton(
                title: viewModel.title,
                url: viewModel.url
            )
        }
        .padding()
    }
}

// MARK: - PreviewProvider

struct BookmarkActionPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkActionPopoverView(
            viewModel: .init(
                isPrivate: true,
                title: "Some fake title",
                url: URL(string: "https://otavio.cc")!
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
