import SwiftUI

struct ShareButton: View {

    // MARK: - Properties

    @State private var showPicker = false

    private let title: String
    private let url: URL

    // MARK: - Life cycle

    init(
        title: String,
        url: URL
    ) {
        self.title = title
        self.url = url
    }

    // MARK: - Public

    var body: some View {
        Button(
            action: { showPicker = true },
            label: {
                Image(systemName: Icon.share)
                    .font(.title3)
                    .foregroundColor(.accentColor)
            }
        )
        .buttonStyle(PlainButtonStyle())
        .background(
            SharingServicePicker(
                isPresented: $showPicker,
                sharingItems: [
                    title,
                    url.absoluteString
                ]
            )
        )
        .help("Share this bookmark")
    }
}

// MARK: - LibraryContentProvider

struct ShareButton_LibraryContent: LibraryContentProvider {

    var views: [LibraryItem] {
        LibraryItem(
            ShareButton(
                title: "Apple's website",
                url: URL(string: "https://www.apple.com")!
            ),
            title: "Open Share Sheet",
            category: .layout
        )
    }
}

// MARK: - PreviewProvider

struct ShareButton_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ShareButton(
                title: "Apple's website",
                url: URL(string: "https://www.apple.com")!
            )
            .preferredColorScheme(.light)

            ShareButton(
                title: "Apple's website",
                url: URL(string: "https://www.apple.com")!
            )
            .preferredColorScheme(.dark)
        }
    }
}
