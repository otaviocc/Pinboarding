import Combine
import Network

final class OfflineViewModel: ObservableObject {

    // MARK: - Properties

    @Published private(set) var isOnline = false

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
