import Combine
import Foundation
import MicroContainer
import Network

final class ViewModelFactory: ObservableObject {

    private let container: DependencyContainer

    init(
        container: DependencyContainer
    ) {
        self.container = container
    }

    func makeMainViewModel(
    ) -> MainViewModel {
        MainViewModel()
    }

    func makeAddBookmarkViewModel(
    ) -> AddBookmarkViewModel {
        AddBookmarkViewModel(
            repository: container.resolve(),
            settingsStore: container.resolve()
        )
    }

    func makeRefreshViewModel(
    ) -> RefreshViewModel {
        RefreshViewModel(
            repository: container.resolve()
        )
    }

    func makeGeneralViewModel(
    ) -> GeneralViewModel {
        GeneralViewModel(
            settingsStore: container.resolve()
        )
    }

    func makeBookmarkViewModel(
        bookmark: Bookmark
    ) -> BookmarkViewModelProtocol {
        BookmarkViewModel(
            bookmark: bookmark
        )
    }

    func makeBookmarkActionPopoverViewModel(
        isPrivate: Bool,
        title: String,
        url: URL
    ) -> BookmarkActionPopoverViewModel {
        BookmarkActionPopoverViewModel(
            isPrivate: isPrivate,
            title: title,
            url: url
        )
    }

    func makeMyBookmarksSectionViewModel(
    ) -> MyBookmarksSectionViewModel {
        MyBookmarksSectionViewModel()
    }

    func makeLoginViewModel(
    ) -> LoginViewModel {
        LoginViewModel(
            tokenStore: container.resolve()
        )
    }

    func makeOfflineViewModel(
    ) -> OfflineViewModel {
        let publisher: NWPathMonitorPathPublishing = container.resolve()

        return OfflineViewModel(
            pathMonitorPublisher: publisher.pathPublisher()
        )
    }

    func makeSearchBarViewModel(
    ) -> SearchTextViewModel {
        SearchTextViewModel(
            searchStore: container.resolve()
        )
    }

    func makeSidebarViewModel(
    ) -> SidebarViewModel {
        let searchStore: SearchStore = container.resolve()
        let repository: PinboardRepositoryProtocol = container.resolve()
        let publisher = repository.networkActivityPublisher()

        return SidebarViewModel(
            networkActivityPublisher: publisher,
            searchStore: searchStore
        )
    }
}
