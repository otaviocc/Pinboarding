import Combine
import Foundation

extension Preview {

    static func makeNetworkActivityPublisher(
        loading: Bool
    ) -> AnyPublisher<NetworkControllerEvent, Never> {
        Just(loading ? .loading : .finishedLoading)
            .eraseToAnyPublisher()
    }
}
