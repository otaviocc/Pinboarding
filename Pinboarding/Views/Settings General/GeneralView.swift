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
        VStack(alignment: .trailing, spacing: 12) {
            Toggle("Mark new posts as private", isOn: $viewModel.isPrivate)
                .toggleStyle(SwitchToggleStyle())

            Toggle("Mark new posts to read later", isOn: $viewModel.isToRead)
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
