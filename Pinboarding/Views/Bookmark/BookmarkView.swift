import SwiftUI

struct BookmarkView: View {

    // MARK: - Properties

    private let viewModel: BookmarkViewModelProtocol

    // MARK: - Life cycle

    init(
        viewModel: BookmarkViewModelProtocol
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(viewModel.title)
                    .font(.title)
                    .foregroundColor(.accentColor)

                Spacer()

                HStack(alignment: .center, spacing: 8) {
                    PrivateView(
                        isPrivate: viewModel.isPrivate
                    )

                    SafariButton(
                        url: viewModel.url
                    )

                    ShareButton(
                        title: viewModel.title,
                        url: viewModel.url
                    )
                }
            }

            if !viewModel.description.isEmpty {
                Text(viewModel.description)
                    .font(.body)
                    .foregroundColor(.primary)
            }

            HStack {
                Spacer()

                Text(viewModel.tags)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

// MARK: - PreviewProvider

struct BookmarkView_Previews: PreviewProvider {

    struct BookmarkMock: BookmarkViewModelProtocol {
        var title = "Lorem Ipsum"
        var description = "Nulla purus urna, fermentum eu tristique non, bibendum nec purus."
        var tags = "tag1, tag2, tag3, tag4"
        var url = URL(string: "https://otaviocc.github.io")!
        var isPrivate = true
    }

    struct EmptyDescriptionBookmarkMock: BookmarkViewModelProtocol {
        var title = "Lorem Ipsum"
        var description = ""
        var tags = "tag1, tag2, tag3, tag4"
        var url = URL(string: "https://otaviocc.github.io")!
        var isPrivate = false
    }

    static var previews: some View {
        Group {
            BookmarkView(viewModel: BookmarkMock())
                .frame(width: 320)
                .preferredColorScheme(.light)

            BookmarkView(viewModel: BookmarkMock())
                .frame(width: 320)
                .preferredColorScheme(.dark)

            BookmarkView(viewModel: EmptyDescriptionBookmarkMock())
                .frame(width: 320)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
