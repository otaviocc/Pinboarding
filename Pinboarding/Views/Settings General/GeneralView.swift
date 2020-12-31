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
        VStack(alignment: .leading, spacing: 12) {
            makeNewBookmarksSection()
            makeReadingSection()
        }
    }

    // MARK: - Private

    private func makeNewBookmarksSection(
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Bookmarks")

            Text("Default values for new bookmarks.")
                .font(.footnote)

            Toggle("Mark as private", isOn: $viewModel.isPrivate)
                .toggleStyle(SwitchToggleStyle())

            Toggle("Mark to read later", isOn: $viewModel.isToRead)
                .toggleStyle(SwitchToggleStyle())
        }
    }

    private func makeReadingSection(
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Reading")

            Toggle("Show private icon", isOn: $viewModel.showPrivateIcon)
                .toggleStyle(SwitchToggleStyle())
        }
    }
}

// MARK: - PreviewProvider

struct GeneralView_Previews: PreviewProvider {

    static var previews: some View {
        let userDefaultsStore = Preview.makeUserDefaultsStore()

        Group {
            GeneralView(
                viewModel: GeneralViewModel(
                    userDefaultsStore: userDefaultsStore
                )
            )
            .preferredColorScheme(.light)

            GeneralView(
                viewModel: GeneralViewModel(
                    userDefaultsStore: userDefaultsStore
                )
            )
            .preferredColorScheme(.dark)
        }
    }
}
