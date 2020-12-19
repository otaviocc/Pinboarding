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

    struct BookmarkMock: BookmarkViewModelProtocol {
        var title = "Lorem Ipsum"
        var description = "Nulla purus urna, fermentum eu tristique non, bibendum nec purus."
        var tags: String = "tag1, tag2, tag3, tag4"
    }

    static var previews: some View {
        Group {
            BookmarkView(viewModel: BookmarkMock())
                .frame(width: 320)
                .preferredColorScheme(.light)

            BookmarkView(viewModel: BookmarkMock())
                .frame(width: 320)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
