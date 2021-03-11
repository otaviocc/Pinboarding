import SwiftUI

struct PrivateView: View {

    // MARK: - Properties

    private let isPrivate: Bool

    // MARK: - Life cycle

    init(
        isPrivate: Bool
    ) {
        self.isPrivate = isPrivate
    }

    // MARK: - Public

    var body: some View {
        Image(
            systemName: isPrivate ? Icon.lockPrivate : Icon.lockPublic
        )
        .font(.title3)
        .foregroundColor(.accentColor)
        .help("Bookmark visibility")
    }
}

// MARK: - LibraryContentProvider

struct PrivateView_LibraryContent: LibraryContentProvider {

    var views: [LibraryItem] {
        LibraryItem(
            PrivateView(
                isPrivate: true
            ),
            title: "Provate Icon",
            category: .layout
        )
    }
}

// MARK: - PreviewProvider

struct PrivateView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            PrivateView(
                isPrivate: true
            )
            .preferredColorScheme(.light)

            PrivateView(
                isPrivate: false
            )
            .preferredColorScheme(.dark)
        }
    }
}
