import SwiftUI

struct BookmarkView: View {

    // MARK: - Properties

    let viewModel: BookmarkViewModel

    // MARK: - Life cycle

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.title)
                .font(.title)
                .foregroundColor(.accentColor)

            Text(viewModel.description)
                .font(.body)
                .foregroundColor(.primary)

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

    static var previews: some View {
        Group {
            BookmarkView(viewModel: makeBookmarkViewModelMock())
                .frame(width: 320)
                .preferredColorScheme(.light)

            BookmarkView(viewModel: makeBookmarkViewModelMock())
                .frame(width: 320)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }

    private static func makeBookmarkViewModelMock() -> BookmarkViewModel {
        BookmarkViewModel(
            bookmark: makeBookmarkMock()
        )
    }

    private static func makeBookmarkMock() -> Bookmark {
        Bookmark(
            href: "",
            title: "Lorem Ipsum",
            description: "Nulla purus urna, fermentum eu tristique non, bibendum nec purus.",
            meta: "",
            hash: "",
            time: Date(),
            isShared: true,
            isToRead: false,
            tags: ["tag1", "tag2", "tag3", "tag4", "tag5"]
        )
    }
}
