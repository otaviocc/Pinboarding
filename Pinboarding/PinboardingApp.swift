import SwiftUI

@main struct PinboardingApp: App {

    // MARK: - Properties

    private let appEnvironment = PinboardingAppEnvironment()

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appEnvironment.repository)
                .environmentObject(appEnvironment.userDefaultsStore)
                .environment(
                    \.managedObjectContext,
                    appEnvironment.persistenceController.container.viewContext
                )
        }
        .commands {
            SidebarCommands()
        }

        Settings {
            SettingsView()
                .environmentObject(appEnvironment.userDefaultsStore)
        }
    }
}
