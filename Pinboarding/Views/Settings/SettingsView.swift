import SwiftUI

struct SettingsView: View {

    // MARK: - Nested types

    private enum SettingsTab: Hashable {
        case login, general
    }

    // MARK: - Properties

    @ObservedObject private var viewModel: SettingsViewModel

    // MARK: - Life cycle

    init(
        viewModel: SettingsViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        TabView {
            LoginView(viewModel: LoginViewModel())
                .tabItem {
                    Label("Login", systemImage: "person")
                }
                .tag(SettingsTab.login)

            GeneralView(viewModel: GeneralViewModel())
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
            SettingsView(viewModel: SettingsViewModel())
                .preferredColorScheme(.light)

            SettingsView(viewModel: SettingsViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
