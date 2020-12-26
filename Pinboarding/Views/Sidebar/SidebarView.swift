import SwiftUI

struct SidebarView: View {

    // MARK: - Properties

    private let viewModel: SidebarViewModel

    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(entity: Tag.entity(), sortDescriptors: [.makeSortByNameAscending()])
    private var tags: FetchedResults<Tag>

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
                ForEach(viewModel.primaryItems, id: \.self) { item in
                    NavigationLink(
                        destination: Text(item.title),
                        label: {
                            SidebarItemView(
                                title: item.title,
                                iconName: item.iconName
                            )
                        }
                    )
                }
            }

            Section(header: Text("Tags")) {
                ForEach(tags, id: \.self) { tag in
                    NavigationLink(
                        destination: Text(tag.name),
                        label: {
                            SidebarItemView(
                                title: tag.name,
                                iconName: "tag"
                            )
                        }
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
        let controller = Preview.makePersistenceControllerInMemory()

        SidebarView(viewModel: SidebarViewModel())
            .frame(width: 200)
            .environment(
                \.managedObjectContext,
                controller.container.viewContext
            )
    }
}
