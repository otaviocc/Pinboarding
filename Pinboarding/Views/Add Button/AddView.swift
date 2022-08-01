import SwiftUI

struct AddView: View {

    @Binding private var showAddBookmark: Bool

    init(
        showAddBookmark: Binding<Bool>
    ) {
        self._showAddBookmark = showAddBookmark
    }

    var body: some View {
        Button(
            action: { showAddBookmark.toggle() },
            label: { Image(systemName: Asset.Action.add) }
        )
        .help("Add a new bookmark")
    }
}
