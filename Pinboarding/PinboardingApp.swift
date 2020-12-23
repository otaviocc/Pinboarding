import SwiftUI

@main struct PinboardingApp: App {

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(PinboardRepository.shared)
                .environment(\.managedObjectContext, PinboardRepository.shared.persistenceController.container.viewContext)
        }
        .commands {
            SidebarCommands()
        }

        Settings {
            SettingsView()
        }
    }
}
