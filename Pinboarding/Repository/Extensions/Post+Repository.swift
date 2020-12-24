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
        post.abstract = postResponse.extended
        post.meta = postResponse.meta
        post.time = postResponse.time
        post.isShared = postResponse.shared.booleanValue
        post.isToRead = postResponse.toread.booleanValue
        post.id = postResponse.hash

        let tags: [Tag] = postResponse.tags
            .split(separator: " ")
            .map(String.init)
            .map { name in
                let tag = Tag(context: context)
                tag.name = name.lowercased()
                return tag
            }
        post.tags = NSSet(array: tags)

        try context.save()

        return post
    }
}
