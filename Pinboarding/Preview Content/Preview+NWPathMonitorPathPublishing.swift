import Combine
import Foundation
import Network

extension Preview {

    // MARK: - Nested types

    final class PathMonitorPublisher: NWPathMonitorPathPublishing {

        private let isOnline: Bool

        init(
            isOnline: Bool
        ) {
            self.isOnline = isOnline
        }

        func pathPublisher() -> AnyPublisher<NWPath.Status, Never> {
            pathPublisher(queue: .main)
        }

        func pathPublisher(
            queue: DispatchQueue
        ) -> AnyPublisher<NWPath.Status, Never> {
            Just(isOnline ? .satisfied : .unsatisfied)
                .eraseToAnyPublisher()
        }
    }

    /// Creates a publisher which Publishes network status for
    /// Swift UI Previews.
    static func makePathMonitorPublisher(
        isOnline: Bool
    ) -> PathMonitorPublisher {
        PathMonitorPublisher(
            isOnline: isOnline
        )
    }
}
