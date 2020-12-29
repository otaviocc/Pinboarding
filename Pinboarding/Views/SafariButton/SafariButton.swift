import SwiftUI

struct SafariButton: View {

    // MARK: - Properties

    @Environment(\.openURL) private var openURL

    private let url: URL

    init(
        url: URL
    ) {
        self.url = url
    }

    var body: some View {
        Button(
            action: { openURL(url) },
            label: {
                Image(systemName: "safari")
                    .font(.title3)
                    .foregroundColor(.accentColor)
            }
        )
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - LibraryContentProvider

struct SafariButton_LibraryContent: LibraryContentProvider {

    var views: [LibraryItem] {
        LibraryItem(
            SafariButton(
                url: URL(string: "https://www.apple.com")!
            ),
            title: "Open URL on Browser",
            category: .layout
        )
    }
}

// MARK: - PreviewProvider

struct SafariButton_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SafariButton(
                url: URL(string: "https://www.apple.com")!
            )
            .preferredColorScheme(.light)

            SafariButton(
                url: URL(string: "https://www.apple.com")!
            )
            .preferredColorScheme(.dark)
        }
    }
}
