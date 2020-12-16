import SwiftUI

struct ActionButtonStyle: ButtonStyle {

    func makeBody(
        configuration: Configuration
    ) -> some View {
        configuration.label
            .foregroundColor(.accentColor)
    }
}

struct DestructiveButtonStyle: ButtonStyle {

    func makeBody(
        configuration: Configuration
    ) -> some View {
        configuration.label
            .foregroundColor(.red)
    }
}

// MARK: - PreviewProvider

struct ButtonStyle_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            Button("Cancel") {}
                .buttonStyle(DestructiveButtonStyle())

            Button("Save") {}
                .buttonStyle(ActionButtonStyle())
        }
        .padding()
        .buttonStyle(ActionButtonStyle())
    }
}
