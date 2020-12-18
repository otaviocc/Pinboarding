import SwiftUI

@main
struct PinboardingApp: App {

    // MARK: - Life cycle

    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .commands {
            SidebarCommands()
        }
    }
}
