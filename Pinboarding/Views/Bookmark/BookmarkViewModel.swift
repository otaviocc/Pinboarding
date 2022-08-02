import Combine
import Foundation

final class BookmarkViewModel: ObservableObject {

    // MARK: - Properties

    @Published var shouldShowWebsiteIcon: Bool

    let title: String
    let description: String
    let tags: String
    let url: URL
    let hostURL: String
    let iconURL: URL?
    let isPrivate: Bool

    private var cancellable: AnyCancellable?

    // MARK: - Life cycle

    init(
        title: String,
        description: String,
        tags: String,
        url: URL,
        hostURL: String,
        iconURL: URL?,
        isPrivate: Bool,
        shouldShowWebsiteIcon: Bool
    ) {
        self.title = title
        self.description = description
        self.tags = tags
        self.url = url
        self.hostURL = hostURL
        self.iconURL = iconURL
        self.isPrivate = isPrivate
        self.shouldShowWebsiteIcon = shouldShowWebsiteIcon
    }

    init(
        bookmark: Bookmark,
        settingsStore: SettingsStore
    ) {
        self.title = bookmark.title
        self.description = bookmark.abstract
        self.isPrivate = !bookmark.isShared
        self.shouldShowWebsiteIcon = settingsStore.showWebsiteIcons

        self.url = URL(string: bookmark.href)
            ?? URL(string: "https://www.pinboard.in")!

        self.hostURL = url.host?.uppercased() ?? ""

        self.iconURL = URL(
            string: "https://www.google.com/s2/favicons?sz=16&domain=\(url.host!)"
        )

        self.tags = bookmark.tags
            .compactMap { $0 as? Tag }
            .map(\.name)
            .joined(separator: ", ")

        self.cancellable = settingsStore
            .changesPublisher()
            .sink { [weak self] change in
                guard case let .showWebsiteIcons(value) = change else {
                    return
                }

                self?.shouldShowWebsiteIcon = value
            }
    }
}
