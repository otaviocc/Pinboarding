import Foundation
import PinboardKit

extension Bookmark {

    static func makeBookmark(
        from post: Post
    ) -> Bookmark {
        Bookmark(
            href: post.href,
            title: post.title,
            description: post.extended,
            meta: post.meta,
            hash: post.id,
            time: post.time,
            isShared: post.shared.booleanValue,
            isToRead: post.toread.booleanValue,
            tags: post.tags.components(separatedBy: " ")
        )
    }
}
