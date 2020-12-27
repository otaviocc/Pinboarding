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
            makeMainSection()
            makeTagsSection()
        }
        .listStyle(SidebarListStyle())
    }

    func makeMainSection() -> some View {
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

    func makeTagsSection() -> some View {
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
    }
}

// MARK: - PreviewProvider

struct SidebarView_Previews: PreviewProvider {

    static var previews: some View {
        let controller = Preview.makePersistenceController(
            populated: true
        )

        Group {
            SidebarView(viewModel: SidebarViewModel())
                .preferredColorScheme(.light)
                .frame(width: 200)

            SidebarView(viewModel: SidebarViewModel())
                .preferredColorScheme(.dark)
                .frame(width: 200)
        }
        .environment(
            \.managedObjectContext,
            controller.container.viewContext
        )
    }
}
