import Foundation

extension NSSortDescriptor {

    /// Sorts by time in descending direction,
    /// used to sort bookmarks.
    static func makeSortByTimeDescending(
    ) -> NSSortDescriptor {
        .init(
            key: "time",
            ascending: false
        )
    }

    /// Sorts by name in ascending direction,
    /// used to sort tags on the sidebar.
    static func makeSortByNameAscending(
    ) -> NSSortDescriptor {
        .init(
            key: "name",
            ascending: true
        )
    }
}
