import Combine
import CoreData
import PinboardKit

protocol PersistenceControllerProtocol {

    func allPostsPublisher() -> AnyPublisher<[Post], Never>
}
