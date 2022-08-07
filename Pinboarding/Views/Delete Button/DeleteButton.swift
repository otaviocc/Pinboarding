import SwiftUI

struct DeleteButton: View {

    // MARK: - Properties

    private let url: URL
    private let action: () -> Void

    // MARK: - Life cycle

    init(
        url: URL,
        action: @escaping () -> Void
    ) {
        self.url = url
        self.action = action
    }

    // MARK: - Public

    var body: some View {
        Button(
            action: { action() },
            label: {
                HStack {
                    Image(systemName: Asset.Action.open)
                        .font(.title3)
                        .foregroundColor(.accentColor)

                    Text("Delete")
                }
            }
        )
        .buttonStyle(PlainButtonStyle())
        .help("Delete bookmark")
    }
}

// MARK: - PreviewProvider

struct DeleteButton_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            DeleteButton(
                url: URL(string: "https://www.apple.com")!,
                action: {}
            )
            .preferredColorScheme(.light)

            DeleteButton(
                url: URL(string: "https://www.apple.com")!,
                action: {}
            )
            .preferredColorScheme(.dark)
        }
    }
}
