import Combine
import Foundation
import PinboardKit

public struct PinboardRepository: PinboardRepositoryProtocol {

    // MARK: - Properties

    private let pinboardAPI: PinboardAPI

    // MARK: - Life cycle

    init(
        pinboardAPI: PinboardAPI
    ) {
        self.pinboardAPI = pinboardAPI
    }
}

// MARK: - Bookmarks

extension PinboardRepository {

    func addBookmark(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: Bool? = nil,
        shared: Bool? = nil,
        toread: Bool? = nil
    ) -> AnyPublisher<Bool, Error> {
        pinboardAPI.add(
            url: url,
            description: description,
            extended: extended,
            tags: tags,
            date: date,
            replace: replace?.stringValue,
            shared: shared?.stringValue,
            toread: toread?.stringValue
        )
        .map { $0.resultCode == "done" }
        .eraseToAnyPublisher()
    }

    func deleteBookmark(
        url: URL
    ) -> AnyPublisher<Bool, Error> {
        pinboardAPI.delete(url: url)
            .map { $0.resultCode == "done" }
            .eraseToAnyPublisher()
    }

    func allBookmarks(
        tag: String? = nil,
        start: Int? = nil,
        results: Int? = nil,
        fromDate: Date? = nil,
        toDate: Date? = nil,
        meta: Int? = nil
    ) -> AnyPublisher<[Bookmark], Error> {
        pinboardAPI.all(
            tag: tag,
            start: start,
            results: results,
            fromDate: fromDate,
            toDate: toDate,
            meta: meta
        )
        .map { response in
            response.posts.map(Bookmark.makeBookmark(from:))
        }
        .eraseToAnyPublisher()
    }

    func recentBookmarks(
        tag: String? = nil,
        count: Int? = nil
    ) -> AnyPublisher<[Bookmark], Error> {
        pinboardAPI.recents(
            tag: tag,
            count: count
        )
        .map { response in
            response.posts.map(Bookmark.makeBookmark(from:))
        }
        .eraseToAnyPublisher()
    }
}
