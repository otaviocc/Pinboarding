import Combine
import MicroContainer

final class ViewModelFactory: ObservableObject {

    private let container: DependencyContainer

    init(
        container: DependencyContainer
    ) {
        self.container = container
    }

    func makeAddBookmarkViewModel() -> AddBookmarkViewModel {
        AddBookmarkViewModel(
            repository: container.resolve(),
            settingsStore: container.resolve()
        )
    }

    func makeRefreshViewModel() -> RefreshViewModel {
        RefreshViewModel(
            repository: container.resolve()
        )
    }

    func makeGeneralViewModel() -> GeneralViewModel {
        GeneralViewModel(
            settingsStore: container.resolve()
        )
    }

    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            tokenStore: container.resolve()
        )
    }

    func makeSidebarViewModel() -> SidebarViewModel {
        let searchStore: SearchStore = container.resolve()
        let repository: PinboardRepository = container.resolve()
        let publisher = repository.networkActivityPublisher()

        return SidebarViewModel(
            networkActivityPublisher: publisher,
            searchStore: searchStore
        )
    }
}
