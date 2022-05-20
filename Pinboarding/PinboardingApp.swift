import SwiftUI
import Foundation

@main struct PinboardingApp: App {

    // MARK: - Properties

    private let appEnvironment = PinboardingAppEnvironment()

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appEnvironment.repository)
                .environmentObject(appEnvironment.settingsStore)
                .environmentObject(appEnvironment.tokenStore)
                .environmentObject(appEnvironment.searchStore)
                .environment(
                    \.managedObjectContext,
                    appEnvironment.persistenceService.container.viewContext
                )
        }
        .commands {
            SidebarCommands()
            BookmarkCommands(
                repository: appEnvironment.repository
            )
        }

        Settings {
            SettingsView()
                .environmentObject(appEnvironment.settingsStore)
                .environmentObject(appEnvironment.tokenStore)
        }
    }
}
