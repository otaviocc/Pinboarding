import Foundation
import SwiftUI

struct BookmarkView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModelFactory: ViewModelFactory
    @ObservedObject private var viewModel: BookmarkViewModel
    @State private var isPopoverPresented = false


    // MARK: - Life cycle

    init(
        viewModel: BookmarkViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if viewModel.shouldShowWebsiteIcon {
                makeWebsideIcon()
            }

            VStack(alignment: .leading, spacing: 4) {
                makeHeader()

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
                        .lineSpacing(2)
                        .truncationMode(.tail)
                }

                Text(viewModel.tags)
                    .font(.footnote)
                    .foregroundColor(.accentColor)
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
    func makeWebsideIcon(
    ) -> some View {
        AsyncImage(url: viewModel.iconURL) { phase in
            if let image = phase.image {
                image
            } else {
                Image(systemName: "link")
            }
        }
        .frame(width: 16, height: 16)
    }

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

    @ViewBuilder
    func makeHeader(
    ) -> some View {
        HStack(alignment: .center, spacing: 2) {
            Text(viewModel.hostURL)
                .font(.caption)
                .foregroundColor(.secondary)

            PrivateView(
                isPrivate: viewModel.isPrivate
            )
            .font(.caption)
            .foregroundColor(.secondary)
        }
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
        }
        .previewLayout(.sizeThatFits)
    }
}
