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
        let searchField = NSSearchField()
        searchField.delegate = context.coordinator
        return searchField
    }

    func updateNSView(
        _ control: NSSearchField,
        context: Context
    ) {
    }

    func makeCoordinator(
    ) -> Coordinator {
        Coordinator(searchField: self)
    }

    final class Coordinator: NSObject, NSSearchFieldDelegate {

        // MARK: - Properties

        private let searchField: SearchField

        // MARK: - Life cycle

        fileprivate init(
            searchField: SearchField
        ) {
            self.searchField = searchField
        }

        // MARK: - Public

        func controlTextDidChange(
            _ notification: Notification
        ) {
            guard
                let control = notification.object as? NSSearchField
            else {
                return
            }

            searchField.searchTerm = control.stringValue
        }
    }
}
