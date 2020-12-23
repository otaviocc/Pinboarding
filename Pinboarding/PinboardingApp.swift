import SwiftUI

@main struct PinboardingApp: App {

    // MARK: - Properties

    private let repository = PinboardRepository()

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(repository)
                .environment(
                    \.managedObjectContext,
                    repository.persistenceController.container.viewContext
                )
        }
        .commands {
            SidebarCommands()
        }

        Settings {
            SettingsView()
        }
    }
}
