import SwiftUI

struct OfflineView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: OfflineViewModel

    // MARK: - Life cycle

    init(
        viewModel: OfflineViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        if !viewModel.isOnline {
            Button(
                action: { },
                label: {
                    Image(systemName: Icon.alert)
                }
            )
            .help("Offline")
        } else {
            EmptyView()
        }
    }
}
