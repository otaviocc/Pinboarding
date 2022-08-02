import Foundation

extension Preview {

    static func makeBookmarkViewModel(
    ) -> BookmarkViewModel {
        BookmarkViewModel(
            title: "Lorem Ipsum",
            description: "Nulla purus urna, fermentum eu tristique non, bibendum nec purus.",
            tags: "tag1, tag2, tag3, tag4",
            url: URL(string: "https://otaviocc.github.io")!,
            hostURL: "OTAVIO.CC",
            iconURL: nil,
            isPrivate: true,
            shouldShowWebsiteIcon: true
        )
    }

    static func makeEmptyBookmarkViewModel(
    ) -> BookmarkViewModel {
        BookmarkViewModel(
            title: "Lorem Ipsum",
            description: "",
            tags: "tag1, tag2, tag3, tag4",
            url: URL(string: "https://otaviocc.github.io")!,
            hostURL: "OTAVIO.CC",
            iconURL: nil,
            isPrivate: true,
            shouldShowWebsiteIcon: false
        )
    }
}
