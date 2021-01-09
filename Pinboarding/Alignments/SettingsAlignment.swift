import SwiftUI

struct SettingsAlignment: AlignmentID {

    /// Custom alignment uses in the Settings View
    /// (General tab). Aligns the left-hand side to the
    /// right, and the right-hand side to the left.
    static func defaultValue(
        in context: ViewDimensions
    ) -> CGFloat {
        return context[.leading]
    }
}

extension HorizontalAlignment {

    /// Custom alignment uses in the Settings View
    /// (General tab). Aligns the left-hand side to the
    /// right, and the right-hand side to the left.
    static let settings: HorizontalAlignment =
        HorizontalAlignment(SettingsAlignment.self)
}
