import Combine
import Foundation

protocol PinboardRepositoryProtocol {

    /// All bookmarks, unfiltered.
    func allBookmarksPublisher() -> AnyPublisher<[Bookmark], Never>
}
