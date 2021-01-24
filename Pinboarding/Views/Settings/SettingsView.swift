import SwiftUI

struct SettingsView: View {

    // MARK: - Nested types

    private enum SettingsTab: Hashable {
        case login, general
    }

    // MARK: - Properties

    @EnvironmentObject private var settingsStore: SettingsStore
    @EnvironmentObject private var tokenStore: AnyTokenStore

    // MARK: - Public

    var body: some View {
        TabView {
            LoginView(
                viewModel: LoginViewModel(
                    tokenStore: tokenStore
                )
            )
            .tabItem {
                Label("Login", systemImage: "person")
            }
            .tag(SettingsTab.login)

            GeneralView(
                viewModel: GeneralViewModel(
                    settingsStore: settingsStore
                )
            )
            .tabItem {
                Label("General", systemImage: "gear")
            }
            .tag(SettingsTab.general)
        }
        .padding()
        .frame(width: 500, height: 200)
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
        .environmentObject(Preview.makeSettingsStore())
    }
}
