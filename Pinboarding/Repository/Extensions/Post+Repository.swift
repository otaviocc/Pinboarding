import CoreData
import Foundation
import PinboardKit

extension Post {

    @discardableResult
    static func makePost(
        from postResponse: PostResponse,
        in context: NSManagedObjectContext
    ) throws -> Post {
        let post = Post(
            context: context
        )

        post.href = postResponse.href
        post.title = postResponse.description
        post.extended = postResponse.extended
        post.meta = postResponse.meta
        post.time = postResponse.time
        post.shared = postResponse.shared
        post.toread = postResponse.toread
        post.id = postResponse.hash
        post.tags = postResponse.tags

        try context.save()

        return post
    }
}
