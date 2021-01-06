import Combine
import Foundation

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

extension Preview {

    /// Network Controller for Swift UI Previews.
    static func makeNetworkController(
    ) -> NetworkController {
        NetworkController(
            settingsStore: Preview.makeSettingsStore()
        )
    }
}
