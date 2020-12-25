import Foundation

extension NSSortDescriptor {

    static func makeSortByTimeDescending(
    ) -> NSSortDescriptor {
        NSSortDescriptor(
            key: "time",
            ascending: false
        )
    }

    static func makeSortByNameAscending(
    ) -> NSSortDescriptor {
        NSSortDescriptor(
            key: "name",
            ascending: true
        )
    }
}
