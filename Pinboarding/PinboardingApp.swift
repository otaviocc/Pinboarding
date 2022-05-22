import SwiftUI
import Foundation

@main struct PinboardingApp: App {

    // MARK: - Properties

    private let container = PinboardingAppContainer()

    // MARK: - Public

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(container.container.resolve(type: PinboardRepository.self))
                .environmentObject(container.container.resolve(type: SettingsStore.self))
                .environmentObject(container.container.resolve(type: AnyTokenStore.self))
                .environmentObject(container.container.resolve(type: SearchStore.self))
                .environment(
                    \.managedObjectContext,
                     (container.container.resolve(type: PersistenceServiceProtocol.self) as! PersistenceService).container.viewContext
                )
        }
        .commands {
            SidebarCommands()
            BookmarkCommands(
                repository: container.container.resolve(type: PinboardRepository.self)
            )
        }

        Settings {
            SettingsView()
                .environmentObject(container.container.resolve(type: SettingsStore.self))
                .environmentObject(container.container.resolve(type: AnyTokenStore.self))
        }
    }
}
