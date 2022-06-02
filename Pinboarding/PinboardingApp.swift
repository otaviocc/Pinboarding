import SwiftUI
import Foundation

@main struct PinboardingApp: App {

    // MARK: - Properties

    private let environment = PinboardingAppEnvironment()

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(environment.viewModelFactory)
                .environmentObject(environment.searchStore)
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

        WindowGroup("New Bookmark") {
            AddBookmarkView(
                viewModel: environment.viewModelFactory.makeAddBookmarkViewModel()
            )
            .frame(width: 640)
            .environment(
                \.managedObjectContext,
                 environment.persistenceService.container.viewContext
            )
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "addbookmark"))

        Settings {
            SettingsView()
                .environmentObject(environment.viewModelFactory)
        }
    }
}
