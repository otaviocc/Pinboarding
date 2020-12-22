import Combine
import Foundation
import PinboardKit

protocol NetworkControllerProtocol {

    /// Emits `PostResponses` every 15 minutes.
    func updates() -> AnyPublisher<[PostResponse], Never>
}
