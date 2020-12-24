import SwiftUI

struct SettingsView: View {

    // MARK: - Nested types

    @EnvironmentObject var settingsStore: SettingsStore

    private enum SettingsTab: Hashable {
        case login, general
    }

    // MARK: - Public

    var body: some View {
        TabView {
            LoginView(viewModel: LoginViewModel(settingsStore: settingsStore))
                .tabItem {
                    Label("Login", systemImage: "person")
                }
                .tag(SettingsTab.login)

            GeneralView(viewModel: GeneralViewModel(settingsStore: settingsStore))
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(SettingsTab.general)
        }
        .padding(16)
        .frame(width: 375, height: 200)
    }
}

// MARK: - PreviewProvider

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SettingsView()
                .preferredColorScheme(.light)

            SettingsView()
                .preferredColorScheme(.dark)
        }
    }
}
