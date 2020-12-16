import SwiftUI

struct LoginView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: LoginViewModel

    // MARK: - Life cycle

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            TextField("Auth Token", text: $viewModel.authToken)

            Button("Save") { }
        }
        .padding()
    }

    // MARK: - Private
}

// MARK: - PreviewProvider

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView(viewModel: LoginViewModel())
                .preferredColorScheme(.light)

            LoginView(viewModel: LoginViewModel())
                .preferredColorScheme(.dark)

        }
        .previewLayout(.fixed(width: 300, height: 100))
    }
}
