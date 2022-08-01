import Foundation
import SwiftUI

struct BookmarkView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModelFactory: ViewModelFactory
    @State private var isPopoverPresented = false

    private let viewModel: BookmarkViewModel

    // MARK: - Life cycle

    init(
        viewModel: BookmarkViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            AsyncImage(url: viewModel.iconURL) { phase in
                if let image = phase.image {
                    image
                } else {
                    Image(systemName: "link")
                }
            }
            .frame(width: 16, height: 16)

            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.hostURL)
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack(alignment: .top) {
                    Text(viewModel.title)
                        .font(.title2)
                        .foregroundColor(.primary)
                        .help(viewModel.url.absoluteString)
                }

                if !viewModel.description.isEmpty {
                    Text(viewModel.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .truncationMode(.tail)
                }

                HStack {
                    Spacer()

                    Text(viewModel.tags)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onTapGesture {
            isPopoverPresented = true
        }
        .popover(isPresented: $isPopoverPresented, arrowEdge: .bottom) {
            makeBookmarkActionView()
        }
        .padding(4)
    }

    // MARK: - Private

    @ViewBuilder
    func makeBookmarkActionView(
    ) -> some View {
        BookmarkActionPopoverView(
            viewModel: viewModelFactory.makeBookmarkActionPopoverViewModel(
                isPrivate: viewModel.isPrivate,
                title: viewModel.title,
                url: viewModel.url
            )
        )
    }
}

// MARK: - PreviewProvider

struct BookmarkView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            BookmarkView(viewModel: Preview.makeBookmarkViewModel())
                .frame(width: 320)
                .preferredColorScheme(.light)

            BookmarkView(viewModel: Preview.makeBookmarkViewModel())
                .frame(width: 320)
                .preferredColorScheme(.dark)

            BookmarkView(viewModel: Preview.makeEmptyBookmarkViewModel())
                .frame(width: 320)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
