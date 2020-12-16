import SwiftUI

struct PostView: View {

    // MARK: - Properties

    let viewModel: PostViewModel

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

struct PostView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            PostView(viewModel: makePostViewModelViewModel())
                .frame(width: 320)
                .preferredColorScheme(.light)

            PostView(viewModel: makePostViewModelViewModel())
                .frame(width: 320)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }

    static func makePostViewModelViewModel() -> PostViewModel {
        PostViewModel(
            title: "Lorem Ipsum",
            description: "Nulla purus urna, fermentum eu tristique non, bibendum nec purus.",
            tags: "tag1, tag2, tag3, tag4, tag5"
        )
    }
}
