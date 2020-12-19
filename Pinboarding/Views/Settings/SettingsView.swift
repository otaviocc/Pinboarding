import SwiftUI

struct SettingsView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: SettingsViewModel

    // MARK: - Life cycle

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pinboard.in Auth Token")

            Text("Pinboarding uses auth token to access Pinboard.in.")
                .font(.footnote)

            TextField(
                "Auth Token",
                text: $viewModel.authToken
            )

            HStack {
                Spacer()
                Button("Save") { }
            }
        }
        .padding()
        .frame(width: 400)
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
        .previewLayout(.fixed(width: 300, height: 100))
    }
}
