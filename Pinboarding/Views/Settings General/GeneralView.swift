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
            Toggle("Mark new posts as private", isOn: $viewModel.isPrivate)
                .toggleStyle(SwitchToggleStyle())
                .alignmentGuide(
                    .leading,
                    computeValue: { d in (d.width - 38) }
                )

            Toggle("Mark new posts to read later", isOn: $viewModel.isToRead)
                .toggleStyle(SwitchToggleStyle())
                .alignmentGuide(
                    .leading,
                    computeValue: { d in (d.width - 38) }
                )

            Toggle("Show private icon", isOn: $viewModel.showPrivateIcon)
                .toggleStyle(SwitchToggleStyle())
                .alignmentGuide(
                    .leading,
                    computeValue: { d in (d.width - 38) }
                )
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
