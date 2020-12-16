import SwiftUI

struct SidebarItemView: View {

    // MARK: - Properties

    let viewModel: SidebarItemViewModel

    // MARK: - Life cycle

    init(
        viewModel: SidebarItemViewModel
    ) {
        self.viewModel = viewModel
    }

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
