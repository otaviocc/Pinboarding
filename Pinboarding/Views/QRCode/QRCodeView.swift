import CoreImage
import SwiftUI

public struct QRCodeView: View {

    // MARK: - Properties

    private var string: String

    // MARK: - Life cycle

    public init(
        string: String
    ) {
        self.string = string
    }

    // MARK: - Public

    public var body: some View {
        Image.makeQRCode(from: string)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
    }
}

// MARK: - Private

private extension Image {

    static func makeQRCode(
        from string: String
    ) -> Image {
        let data = Data(string.utf8)
        let context = CIContext()

        let filter = CIFilter(
            name: "CIQRCodeGenerator"
        )

        filter?.setValue(
            data,
            forKey: "inputMessage"
        )

        let image = filter?
            .outputImage
            .flatMap {
                context.createCGImage(
                    $0,
                    from: $0.extent
                )
            }
            .map {
                Image(
                    $0,
                    scale: 1,
                    label: Text("QRCode")
                )
            }

        return image ?? Image(systemName: Asset.QRCode.placeholder)
    }
}

// MARK: - LibraryContentProvider

struct QRCodeView_LibraryContent: LibraryContentProvider {

    var views: [LibraryItem] {
        LibraryItem(
            QRCodeView(
                string: "Lorem Ipsum"
            ),
            title: "QRCode",
            category: .other
        )
    }
}

// MARK: - PreviewProvider

struct QRCodeView_Previews: PreviewProvider {

    static var previews: some View {
        QRCodeView(string: "Alguma coisa")
            .foregroundColor(.accentColor)
            .frame(width: 300, height: 300)
    }
}
