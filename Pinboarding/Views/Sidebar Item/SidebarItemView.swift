import SwiftUI

struct SidebarItemView: View {

    // MARK: - Properties

    private let title: String
    private let iconName: String

    // MARK: - Life cycle

    init(
        title: String,
        iconName: String
    ) {
        self.title = title
        self.iconName = iconName
    }

    // MARK: - Public

    var body: some View {
        Label(title, systemImage: iconName)
    }
}

// MARK: - PreviewProvider

struct SidebarItemView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SidebarItemView(title: "Foo", iconName: "tag")
                .preferredColorScheme(.light)

            SidebarItemView(title: "Foo", iconName: "tag")
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
