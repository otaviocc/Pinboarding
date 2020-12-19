import SwiftUI

struct SidebarView: View {

    // MARK: - Properties

    private let viewModel: SidebarViewModel

    // MARK: - Life cycle

    init(
        viewModel: SidebarViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        List {
            Section(header: Text("My Bookmarks")) {
                ForEach(viewModel.items, id: \.self) { item in
                    NavigationLink(
                        destination: Text(item.title),
                        label: { SidebarItemView(viewModel: item) }
                    )
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}

// MARK: - PreviewProvider

struct SidebarView_Previews: PreviewProvider {

    static var previews: some View {
        SidebarView(viewModel: SidebarViewModel())
            .frame(width: 200)
    }
}
