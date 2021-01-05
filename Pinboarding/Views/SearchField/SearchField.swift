import Foundation
import SwiftUI

struct SearchField: NSViewRepresentable {

    // MARK: - Properties

    @Binding var searchTerm: String

    // MARK: - Life cycle

    init(
        searchTerm: Binding<String>
    ) {
        self._searchTerm = searchTerm
    }

    // MARK: - Public

    func makeNSView(
        context: Context
    ) -> NSSearchField {
        NSSearchField()
    }

    func updateNSView(
        _ control: NSSearchField,
        context: Context
    ) {
        control.delegate = context.coordinator
    }

    func makeCoordinator(
    ) -> Coordinator {
        Coordinator(searchField: self)
    }

    final class Coordinator: NSObject, NSSearchFieldDelegate {
        let searchField: SearchField

        init(
            searchField: SearchField
        ) {
            self.searchField = searchField
        }

        func controlTextDidChange(
            _ notification: Notification
        ) {
            guard
                let control = notification.object as? NSSearchField
            else {
                return
            }

            searchField.searchTerm = control.stringValue
            control.delegate = nil
        }
    }
}
