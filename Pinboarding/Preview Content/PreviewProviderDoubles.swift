import Foundation
import Combine

#if DEBUG

// MARK: - PinboardRepositoryProtocol

final class PinboardRepositoryMock: PinboardRepositoryProtocol {

    @Published private var bookmarks: [Bookmark] = Bookmark.makeBookmarks()

    func allBookmarksPublisher() -> AnyPublisher<[Bookmark], Never> {
        $bookmarks.eraseToAnyPublisher()
    }
}

// MARK: - Fixtures

extension Bookmark {

    static func makeBookmark(
        hash: String
    ) -> Bookmark {
        Bookmark(
            href: "https://fakeland.mock",
            title: "Fake bookmark Title \(hash)",
            description: "Fake description",
            meta: "meta",
            hash: hash,
            time: Date(),
            isShared: false,
            isToRead: false,
            tags: ["tag1", "tag2"]
        )
    }

    static func makeBookmarks(
        count: Int = 5
    ) -> [Bookmark] {
        var bookmarks: [Bookmark] = []

        for i in 0..<count {
            bookmarks.append(
                makeBookmark(
                    hash: String(i)
                )
            )
        }

        return bookmarks
    }
}

#endif
