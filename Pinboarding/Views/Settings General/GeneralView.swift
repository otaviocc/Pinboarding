import SwiftUI

struct GeneralView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: GeneralViewModel

    // MARK: - Life cycle

    init(
        viewModel: GeneralViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        VStack(alignment: .twoColumns, spacing: 12) {
            HStack {
                Text("Default values for new bookmarks")

                Toggle(
                    "Mark new posts as private",
                    isOn: $viewModel.isPrivate
                )
                .rightColumnAlignmentGuide()
            }

            Toggle(
                "Mark new posts to read later",
                isOn: $viewModel.isToRead
            )
            .rightColumnAlignmentGuide()

            HStack {
                Text("Micro.blog")

                Toggle(
                    "Show \"Read on Micro.blog\"",
                    isOn: $viewModel.showMicroBlog
                )
                .rightColumnAlignmentGuide()
            }

            HStack {
                Text("Images")

                Toggle(
                    "Show website icon",
                    isOn: $viewModel.showWebsiteIcons
                )
                .rightColumnAlignmentGuide()
            }
        }
        .padding()
    }
}

// MARK: - PreviewProvider

struct GeneralView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            GeneralView(
                viewModel: .init(
                    settingsStore: Preview.makeSettingsStore()
                )
            )
            .preferredColorScheme(.light)

            GeneralView(
                viewModel: .init(
                    settingsStore: Preview.makeSettingsStore(
                        isPrivate: false,
                        isToRead: true,
                        showMicroBlog: false
                    )
                )
            )
            .preferredColorScheme(.dark)
        }
    }
}
