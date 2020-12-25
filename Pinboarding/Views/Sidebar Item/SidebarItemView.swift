import SwiftUI

struct SidebarItemView: View {

    // MARK: - Properties

    private let viewModel: SidebarPrimaryItem

    // MARK: - Life cycle

    init(
        viewModel: SidebarPrimaryItem
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        Label(
            viewModel.title,
            systemImage: viewModel.iconName
        )
    }
}

// MARK: - PreviewProvider

struct SidebarItemView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SidebarItemView(viewModel: .public)
                .preferredColorScheme(.light)

            SidebarItemView(viewModel: .private)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
