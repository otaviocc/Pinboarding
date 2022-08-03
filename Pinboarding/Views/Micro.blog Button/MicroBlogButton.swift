import SwiftUI

struct MicroBlogButton: View {

    // MARK: - Properties

    @Environment(\.openURL) private var openURL

    private let viewModel: MicroBlogButtonViewModel

    // MARK: - Life cycle

    init(
        viewModel: MicroBlogButtonViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        Button(
            action: { openURL(viewModel.microblogURL) },
            label: {
                HStack {
                    Image(systemName: Asset.Action.bookmark)
                        .font(.title3)
                        .foregroundColor(.accentColor)

                    Text("Bookmark on Micro.blog")
                }
            }
        )
        .buttonStyle(PlainButtonStyle())
        .help("Open on default browser")
    }
}

// MARK: - PreviewProvider

struct MicroBlogButton_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            MicroBlogButton(
                viewModel: .init(
                    url: URL(string: "https://www.apple.com")!
                )
            )
            .preferredColorScheme(.light)

            MicroBlogButton(
                viewModel: .init(
                    url: URL(string: "https://www.apple.com")!
                )
            )
            .preferredColorScheme(.dark)
        }
    }
}
