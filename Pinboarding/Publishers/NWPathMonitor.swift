import Combine
import Network

protocol NWPathMonitorPathPublishing {
    func pathPublisher(
    ) -> AnyPublisher<NWPath.Status, Never>

    func pathPublisher(
        queue: DispatchQueue
    ) -> AnyPublisher<NWPath.Status, Never>
}

extension NWPathMonitor: NWPathMonitorPathPublishing {

    func pathPublisher(
    )  -> AnyPublisher<NWPath.Status, Never> {
        pathPublisher(queue:  .global(qos: .background))
    }

    public func pathPublisher(
        queue: DispatchQueue
    ) -> AnyPublisher<NWPath.Status, Never> {
        PathMonitorPublisher(
            monitor: self,
            queue: queue
        )
        .eraseToAnyPublisher()
    }
}

extension NWPathMonitor {

    public struct PathMonitorPublisher: Publisher {

        // MARK: - Nested types

        public typealias Output = NWPath.Status
        public typealias Failure = Never

        // MARK: - Properties

        private let monitor: NWPathMonitor
        private let queue: DispatchQueue

        // MARK: - Life cycle

        fileprivate init(
            monitor: NWPathMonitor,
            queue: DispatchQueue
        ) {
            self.monitor = monitor
            self.queue = queue
        }

        // MARK: - Public

        public func receive<S>(
            subscriber: S
        ) where S: Subscriber, S.Failure == Failure, S.Input == Output {
            let subscription = PathMonitorSubscription(
                subscriber: subscriber,
                monitor: monitor,
                queue: queue
            )

            subscriber.receive(
                subscription: subscription
            )
        }
    }

    private final class PathMonitorSubscription<S: Subscriber>: Subscription where S.Input == NWPath.Status {

        // MARK: - Nested types

        private let subscriber: S
        private let monitor: NWPathMonitor
        private let queue: DispatchQueue

        // MARK: - Life cycle

        init(
            subscriber: S,
            monitor: NWPathMonitor,
            queue: DispatchQueue
        ) {
            self.subscriber = subscriber
            self.monitor = monitor
            self.queue = queue
        }

        // MARK: - Public

        func request(
            _ demand: Subscribers.Demand
        ) {
            guard
                demand == .unlimited,
                monitor.pathUpdateHandler == nil
            else {
                return
            }

            monitor.pathUpdateHandler = { path in
                _ = self.subscriber.receive(path.status)
            }

            monitor.start(
                queue: queue
            )
        }

        func cancel() {
            monitor.cancel()
        }
    }
}
