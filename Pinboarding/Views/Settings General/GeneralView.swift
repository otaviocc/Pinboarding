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
        }
        .padding()
    }
}

// MARK: - PreviewProvider

struct GeneralView_Previews: PreviewProvider {

    static var previews: some View {
        let settingsStore = Preview.makeSettingsStore()

        Group {
            GeneralView(
                viewModel: GeneralViewModel(
                    settingsStore: settingsStore
                )
            )
            .preferredColorScheme(.light)

            GeneralView(
                viewModel: GeneralViewModel(
                    settingsStore: settingsStore
                )
            )
            .preferredColorScheme(.dark)
        }
    }
}
