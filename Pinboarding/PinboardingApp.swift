import SwiftUI
import Foundation

@main struct PinboardingApp: App {

    // MARK: - Properties

    private let environment = PinboardingAppEnvironment()

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView(
                viewModel: environment.viewModelFactory.makeMainViewModel()
            )
            .environmentObject(environment.viewModelFactory)
            .environmentObject(environment.searchStore)
            .environmentObject(environment.navigationModel)
            .environment(
                \.managedObjectContext,
                 environment.persistenceService.container.viewContext
            )
        }
        .commands {
            SidebarCommands()

            BookmarkCommands(
                repository: environment.repository
            )
        }

        Settings {
            SettingsView()
                .environmentObject(environment.viewModelFactory)
        }
    }
}
