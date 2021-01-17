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
                            iconName: "tag"
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
        let controller = Preview.makePersistenceController(
            populated: true
        )

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
        .frame(width: 200)
        .environment(
            \.managedObjectContext,
            controller.container.viewContext
        )
    }
}
