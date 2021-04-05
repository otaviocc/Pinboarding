import Combine

extension Preview {

    /// Publishes network activities for
    /// Swift UI Previews.
    static func makeNetworkActivityPublisher(
        loading: Bool
    ) -> AnyPublisher<NetworkActivityEvent, Never> {
        Just(loading ? .loading : .finishedLoading)
            .eraseToAnyPublisher()
    }
}
