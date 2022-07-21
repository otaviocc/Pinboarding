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
        Button(
            action: { },
            label: {
                Image(systemName: "circle")
            }
        )
        .help(viewModel.iconTooltip)
    }
}

// MARK: - PreviewProvider

struct OfflineView_Previews: PreviewProvider {

    static var previews: some View {
        let onlinePublisher = Preview.makeNetworkStatusPublisher(
            isOnline: true
        )

        let offlinePublisher = Preview.makeNetworkStatusPublisher(
            isOnline: false
        )

        Group {
            OfflineView(
                viewModel: .init(
                    pathMonitorPublisher: onlinePublisher
                )
            )
            .preferredColorScheme(.dark)

            OfflineView(
                viewModel: .init(
                    pathMonitorPublisher: offlinePublisher
                )
            )
            .preferredColorScheme(.light)
        }
    }
}
