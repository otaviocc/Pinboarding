import SwiftUI

struct LoginView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: LoginViewModel

    // MARK: - Life cycle

    init(
        viewModel: LoginViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pinboard Auth Token")

            Text("Pinboarding uses auth token to access Pinboard.")
                .font(.footnote)

            Link(
                "View your API key.",
                destination: URL(
                    string: "https://pinboard.in/settings/password"
                )!
            )
            .font(.callout)

            SecureField(
                "Auth Token",
                text: $viewModel.authToken
            )

            HStack {
                if !viewModel.isValid {
                    Text(viewModel.authTokenMessage)
                        .foregroundColor(.red)
                }

                Spacer()

                Button("Save") {
                    viewModel.save()
                }
                .disabled(!viewModel.isValid)
            }
        }
        .padding()
    }
}

// MARK: - PreviewProvider

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            LoginView(
                viewModel: LoginViewModel(
                    tokenStore: Preview.makeTokenStore(authToken: "valid:token")
                )
            )
            .preferredColorScheme(.light)

            LoginView(
                viewModel: LoginViewModel(
                    tokenStore: Preview.makeTokenStore(authToken: "invalidtoken")
                )
            )
            .preferredColorScheme(.dark)
        }
    }
}
