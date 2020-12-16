import Combine
import Foundation

final class PostViewModel {

    // MARK: - Properties

    let title: String
    let description: String
    let tags: String

    // MARK: - Life cycle

    init(
        title: String,
        description: String,
        tags: String
    ) {
        self.title = title
        self.description = description
        self.tags = tags
    }

    // MARK: - Public

    // MARK: - Private
}
