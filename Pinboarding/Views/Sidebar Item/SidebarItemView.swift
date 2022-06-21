import SwiftUI

struct SidebarItemView: View {

    // MARK: - Properties

    private let title: String
    private let iconName: String
    private let counter: String?

    // MARK: - Life cycle

    init(
        title: String,
        iconName: String,
        counter: String? = nil
    ) {
        self.title = title
        self.iconName = iconName
        self.counter = counter
    }

    // MARK: - Public

    var body: some View {
        HStack {
            Label(title, systemImage: iconName)

            Spacer()

            if let counter = counter {
                Text(counter)
                    .padding(2)
                    .frame(minWidth: 24)
                    .background(.gray.opacity(0.2))
                    .clipShape(Capsule(style: .circular))
            }
        }
    }
}

// MARK: - PreviewProvider

struct SidebarItemView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SidebarItemView(
                title: "Foo",
                iconName: "tag"
            )
            .preferredColorScheme(.light)

            SidebarItemView(
                title: "Foo",
                iconName: "tag",
                counter: "42"
            )
            .preferredColorScheme(.dark)
        }
        .frame(width: 200)
    }
}
