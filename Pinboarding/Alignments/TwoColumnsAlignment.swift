import SwiftUI

struct TwoColumnsAlignment: AlignmentID {

    /// Default value for building a table with two columns,
    /// where the left one is aligned to right and the right
    /// one, to the left.
    static func defaultValue(
        in context: ViewDimensions
    ) -> CGFloat {
        return context[.leading]
    }
}

extension HorizontalAlignment {

    /// The two-column horizontal alignment.
    static let twoColumns: HorizontalAlignment =
        HorizontalAlignment(TwoColumnsAlignment.self)
}

extension View {

    /// View modifier to align the right column to the
    /// left side.
    func rightColumnAlignmentGuide() -> some View {
        self.alignmentGuide(.twoColumns) { $0[.leading] }
    }
}

struct SettingsAlignment_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            VStack(alignment: .twoColumns, spacing: 8) {
                HStack {
                    Text("Country")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Population")
                        .font(.title)
                        .fontWeight(.bold)
                        .rightColumnAlignmentGuide()
                }
                HStack {
                    Text("China")
                    Text("1,406,124,800")
                        .rightColumnAlignmentGuide()
                }
                HStack {
                    Text("India")
                    Text("1,371,890,046")
                        .rightColumnAlignmentGuide()
                }
                HStack {
                    Text("United States")
                    Text("330,962,156")
                        .rightColumnAlignmentGuide()
                }
                HStack {
                    Text("Indonesia")
                    Text("269,603,400")
                        .rightColumnAlignmentGuide()
                }
            }
            .padding()
            .preferredColorScheme(.dark)
        }
    }
}
