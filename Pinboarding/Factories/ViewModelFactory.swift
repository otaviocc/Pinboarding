import Combine
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
        return MainViewModel()
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

    func makeSidebarViewModel(
    ) -> SidebarViewModel {
        let searchStore: SearchStore = container.resolve()
        let repository: PinboardRepository = container.resolve()
        let publisher = repository.networkActivityPublisher()

        return SidebarViewModel(
            networkActivityPublisher: publisher,
            searchStore: searchStore
        )
    }
}
