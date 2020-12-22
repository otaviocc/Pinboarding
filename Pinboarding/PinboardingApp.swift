import SwiftUI

@main struct PinboardingApp: App {

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(PinboardRepository.shared)
        }
        .commands {
            SidebarCommands()
        }

        Settings {
            SettingsView(viewModel: SettingsViewModel())
        }
    }
}
