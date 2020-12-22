import Combine
import Foundation
import PinboardKit

public class PinboardRepository: PinboardRepositoryProtocol, ObservableObject {

    // MARK: - Properties

    static let shared = PinboardRepository()

    private let networkController: NetworkController
    private let persistenceController: PersistenceController
    private let bookmarksSubject = PassthroughSubject<[Bookmark], Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    convenience init() {
        self.init(
            networkController: NetworkController(
                settingsController: .shared
            ),
            persistenceController: PersistenceController(
                inMemory: false
            )
        )

        self.synchronizeBookmarksContinuously()
    }

    private init(
        networkController: NetworkController,
        persistenceController: PersistenceController
    ) {
        self.networkController = networkController
        self.persistenceController = persistenceController
    }

    // MARK: - Public

    func allBookmarksPublisher() -> AnyPublisher<[Bookmark], Never> {
        persistenceController.allPostsPublisher()
            .map {
                $0.map(Bookmark.makeBookmark(from:))
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func synchronizeBookmarksContinuously() {
        networkController.updatesPublisher()
            .sink { [weak self] posts in
                self?.persistenceController.appendNewPosts(posts)
            }
            .store(in: &cancellables)
    }
}
