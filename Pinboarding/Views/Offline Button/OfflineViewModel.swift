import Combine
import Network

final class OfflineViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var isOnline = false

    var iconName: String {
        isOnline ? Icon.online : Icon.alert
    }

    var iconTooltip: String {
        isOnline ? "Online" : "Offline"
    }

    private var monitorCancellable: Cancellable?

    // MARK: - Life cycle

    init(
        pathMonitorPublisher: AnyPublisher<NWPath.Status, Never>
    ) {
        monitorCancellable = pathMonitorPublisher
            .receive(on: DispatchQueue.main)
            .map { $0 == .satisfied }
            .assign(to: \.isOnline, on: self)
    }
}
