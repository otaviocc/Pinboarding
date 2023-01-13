import SwiftUI

struct MyBookmarksSectionView: View {

    // MARK: - Properties

    private let viewModel: MyBookmarksSectionViewModel

    // MARK: - Life cycle

    init(
        viewModel: MyBookmarksSectionViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        Section(header: Text("My Bookmarks")) {
            ForEach(viewModel.primaryItems, id: \.self) { item in
                NavigationLink(
                    value: NavigationDestination(item: item),
                    label: {
                        SidebarItemView(
                            title: item.title,
                            iconName: item.iconName
                        )
                    }
                )
            }
        }
        .collapsible(false)
    }
}

// MARK: - PreviewProvider

struct MyBookmarksSectionView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            List {
                MyBookmarksSectionView(
                    viewModel: MyBookmarksSectionViewModel()
                )
                .preferredColorScheme(.light)
            }

            List {
                MyBookmarksSectionView(
                    viewModel: MyBookmarksSectionViewModel()
                )
                .preferredColorScheme(.dark)
            }
        }
        .frame(width: 200)
    }
}
