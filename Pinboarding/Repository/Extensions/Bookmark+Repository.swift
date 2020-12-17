import Foundation
import PinboardKit

extension Bookmark {

    /// Builds a Bookmark from PinboardKit's PostResponse.
    static func makeBookmark(
        from postResponse: PostResponse
    ) -> Bookmark {
        Bookmark(
            href: postResponse.href,
            title: postResponse.description,
            description: postResponse.extended,
            meta: postResponse.meta,
            hash: postResponse.hash,
            time: postResponse.time,
            isShared: postResponse.shared.booleanValue,
            isToRead: postResponse.toread.booleanValue,
            tags: postResponse.tags.components(separatedBy: " ")
        )
    }
}
