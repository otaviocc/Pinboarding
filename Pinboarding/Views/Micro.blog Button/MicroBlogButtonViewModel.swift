import Foundation

final class MicroBlogButtonViewModel {

    // MARK: - Properties

    let microblogURL: URL

    // MARK: - Life cycle

    init(
        url: URL
    ) {
        let fallbackURL = URL(
            string: "https://micro.blog/bookmark"
        )!

        self.microblogURL = url
            .absoluteString
            .addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            )
            .map { encodedURL in
                "https://micro.blog/bookmark?url=\(encodedURL)"
            }
            .flatMap { microblogURLString in
                URL(string: microblogURLString)
            } ?? fallbackURL
    }
}
