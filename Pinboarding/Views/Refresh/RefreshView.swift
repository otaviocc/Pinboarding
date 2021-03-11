import SwiftUI

struct RefreshView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: RefreshViewModel

    // MARK: - Life cycle

    init(
        viewModel: RefreshViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        Button(
            action: { viewModel.refresh() },
            label: {
                Image(systemName: Icon.refresh)
            }
        )
        .disabled(viewModel.isReloading)
    }

    // MARK: - Private
}

// MARK: - PreviewProvider

struct RefreshView_Previews: PreviewProvider {

    static var previews: some View {
        RefreshView(
            viewModel: RefreshViewModel(
                repository: Preview.makeRepository()
            )
        )
    }
}
