import SwiftUI
import Foundation

@main struct PinboardingApp: App {

    // MARK: - Properties

    private let environment = PinboardingAppEnvironment()

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(environment.repository)
                .environmentObject(environment.settingsStore)
                .environmentObject(environment.tokenStore)
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

        Settings {
            SettingsView()
                .environmentObject(environment.settingsStore)
                .environmentObject(environment.tokenStore)
        }
    }
}
