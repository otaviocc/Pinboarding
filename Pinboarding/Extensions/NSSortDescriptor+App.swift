import Foundation

extension NSSortDescriptor {

    static func makeSortByTimeAscending(
    ) -> NSSortDescriptor {
        NSSortDescriptor(
            key: "time",
            ascending: false
        )
    }
}
