import SwiftUI

struct QRCodeButton: View {

    // MARK: - Properties

    @State private var showPopover: Bool = false

    private let url: URL

    // MARK: - Life cycle

    init(
        url: URL
    ) {
        self.url = url
    }

    // MARK: - Public
 
    var body: some View {
        Button(
            action: { showPopover.toggle() },
            label: {
                HStack {
                    Image(systemName: Icon.qrCode)
                        .font(.title3)
                    .foregroundColor(.accentColor)

                    Text("QR Code")
                }
            }
        )
        .buttonStyle(PlainButtonStyle())
        .help("Show QRCode")
        .popover(
            isPresented: $showPopover,
            arrowEdge: .bottom
        ) {
            QRCodeView(string: url.absoluteString)
                .frame(width: 300, height: 300)
        }
    }
}

// MARK: - LibraryContentProvider

struct QRCodeButton_LibraryContent: LibraryContentProvider {

    var views: [LibraryItem] {
        LibraryItem(
            QRCodeButton(
                url: URL(string: "https://www.apple.com")!
            ),
            title: "Show QR Code",
            category: .layout
        )
    }
}

// MARK: - PreviewProvider

struct QRCodeButton_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            QRCodeButton(
                url: URL(string: "https://www.apple.com")!
            )
            .preferredColorScheme(.light)

            QRCodeButton(
                url: URL(string: "https://www.apple.com")!
            )
            .preferredColorScheme(.dark)
        }
    }
}
