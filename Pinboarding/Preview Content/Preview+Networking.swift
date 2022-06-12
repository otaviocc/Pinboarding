import Combine
import Network

extension Preview {

    /// Publishes network activities for
    /// Swift UI Previews.
    static func makeNetworkActivityPublisher(
        loading: Bool
    ) -> AnyPublisher<NetworkActivityEvent, Never> {
        Just(loading ? .loading : .finishedLoading)
            .eraseToAnyPublisher()
    }

    /// Publishes network status for
    /// Swift UI Previews.
    static func makeNetworkStatusPublisher(
        isOnline: Bool
    ) -> AnyPublisher<NWPath.Status, Never> {
        Just(isOnline ? .satisfied : .unsatisfied)
            .eraseToAnyPublisher()
    }
}
