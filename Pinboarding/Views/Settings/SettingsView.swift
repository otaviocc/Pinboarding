import SwiftUI

struct SettingsView: View {

    // MARK: - Nested types

    private enum SettingsTab: Hashable {
        case login, general
    }

    // MARK: - Properties

    @EnvironmentObject private var viewModelFactory: ViewModelFactory

    // MARK: - Public

    var body: some View {
        TabView {
            LoginView(
                viewModel: viewModelFactory.makeLoginViewModel()
            )
            .tabItem {
                Label("Login", systemImage: "person")
            }
            .tag(SettingsTab.login)

            GeneralView(
                viewModel: viewModelFactory.makeGeneralViewModel()
            )
            .tabItem {
                Label("General", systemImage: "gear")
            }
            .tag(SettingsTab.general)
        }
        .padding()
        .frame(width: 500)
    }
}

// MARK: - PreviewProvider

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SettingsView()
                .preferredColorScheme(.light)
                .environmentObject(
                    Preview.makeTokenStore(authToken: "valid:token")
                )

            SettingsView()
                .preferredColorScheme(.dark)
                .environmentObject(
                    Preview.makeTokenStore(authToken: "invalid_token")
                )
        }
        .withPreviewDependencies()
    }
}
