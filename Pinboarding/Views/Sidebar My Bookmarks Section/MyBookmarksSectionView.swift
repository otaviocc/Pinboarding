import SwiftUI

struct MyBookmarksSectionView: View {

    private let viewModel: MyBookmarksSectionViewModel

    init(
        viewModel: MyBookmarksSectionViewModel
    ) {
        self.viewModel = viewModel
    }

    var body: some View {
        Section(header: Text("My Bookmarks")) {
            ForEach(viewModel.primaryItems, id: \.self) { item in
                NavigationLink(
                    destination: BookmarksView(
                        viewModel: item.listType
                    ),
                    label: {
                        SidebarItemView(
                            title: item.title,
                            iconName: item.iconName
                        )
                    }
                )
            }
        }
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
