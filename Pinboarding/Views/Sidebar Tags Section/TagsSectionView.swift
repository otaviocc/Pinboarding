import SwiftUI

struct TagsSectionView: View {

    // MARK: - Properties

    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(entity: Tag.entity(), sortDescriptors: [.makeSortByNameAscending()])
    private var tags: FetchedResults<Tag>

    // MARK: - Public

    var body: some View {
        Section(header: Text("Tags")) {
            ForEach(tags, id: \.self) { tag in
                NavigationLink(
                    destination: BookmarksView(
                        viewModel: .tag(name: tag.name)
                    ),
                    label: {
                        SidebarItemView(
                            title: tag.name,
                            iconName: Asset.Tag.icon,
                            counter: String(tag.bookmarks.count)
                        )
                    }
                )
            }
        }
        .collapsible(false)
    }
}

// MARK: - PreviewProvider

struct TagsSectionView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            List {
                TagsSectionView()
                    .preferredColorScheme(.light)
            }

            List {
                TagsSectionView()
                    .preferredColorScheme(.dark)
            }
        }
        .withPreviewDependencies()
        .frame(width: 200)
    }
}
