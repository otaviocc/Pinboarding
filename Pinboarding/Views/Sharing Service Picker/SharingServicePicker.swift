import Foundation
import SwiftUI

struct SharingServicePicker: NSViewRepresentable {

    // MARK: - Properties

    @Binding private var isPresented: Bool

    private let sharingItems: [Any]

    // MARK: - Life cycle

    init(
        isPresented: Binding<Bool>,
        sharingItems: [Any]
    ) {
        self._isPresented = isPresented
        self.sharingItems = sharingItems
    }

    // MARK: - Public

    func makeNSView(
        context: Context
    ) -> NSView {
        NSView()
    }

    func updateNSView(
        _ nsView: NSView,
        context: Context
    ) {
        guard isPresented else { return }

        let picker = NSSharingServicePicker(
            items: sharingItems
        )

        picker.delegate = context.coordinator

        DispatchQueue.main.async {
            picker.show(
                relativeTo: .zero,
                of: nsView,
                preferredEdge: .minY
            )
        }
    }

    func makeCoordinator(
    ) -> Coordinator {
        Coordinator(picker: self)
    }

    final class Coordinator: NSObject, NSSharingServicePickerDelegate {

        // MARK: - Properties

        private let picker: SharingServicePicker

        // MARK: - Life cycle

        fileprivate init(
            picker: SharingServicePicker
        ) {
            self.picker = picker
        }

        // MARK: - Public

        func sharingServicePicker(
            _ sharingServicePicker: NSSharingServicePicker,
            didChoose service: NSSharingService?
        ) {
            sharingServicePicker.delegate = nil
            picker.isPresented = false
        }
    }
}
