import Foundation
import SwiftUI

struct SharingServicePicker: NSViewRepresentable {

    // MARK: - Properties

    @Binding var isPresented: Bool
    var sharingItems: [Any] = []

    // MARK: - Public

    func makeNSView(context: Context) -> NSView {
        NSView()
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        if isPresented {
            let picker = NSSharingServicePicker(items: sharingItems)
            picker.delegate = context.coordinator

            DispatchQueue.main.async {
                picker.show(
                    relativeTo: .zero,
                    of: nsView,
                    preferredEdge: .minY
                )
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(picker: self)
    }

    final class Coordinator: NSObject, NSSharingServicePickerDelegate {
        let picker: SharingServicePicker

        init(
            picker: SharingServicePicker
        ) {
            self.picker = picker
        }

        func sharingServicePicker(
            _ sharingServicePicker: NSSharingServicePicker,
            didChoose service: NSSharingService?
        ) {
            sharingServicePicker.delegate = nil
            self.picker.isPresented = false
        }
    }
}
