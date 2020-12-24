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
            Text("Pinboard.in Auth Token")

            Text("Pinboarding uses auth token to access Pinboard.in.")
                .font(.footnote)

            TextField(
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
    }
}
