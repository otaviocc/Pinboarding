import SwiftUI

struct LoginView: View {

    // MARK: - Properties

    @Binding private var authToken: String

    // MARK: - Life cycle

    init(
        authToken: Binding<String>
    ) {
        self._authToken = authToken
    }

    // MARK: - Public

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pinboard.in Auth Token")

            Text("Pinboarding uses auth token to access Pinboard.in.")
                .font(.footnote)

            TextField(
                "Auth Token",
                text: $authToken
            )

            HStack {
                Spacer()
                Button("Save") { }
            }
        }
    }
}

// MARK: - PreviewProvider

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            LoginView(
                authToken: .constant("")
            )
            .padding()
            .preferredColorScheme(.light)

            LoginView(
                authToken: .constant("a8858fef15c56d12fc7810b310a4503c")
            )
            .padding()
            .preferredColorScheme(.dark)
        }
    }
}
