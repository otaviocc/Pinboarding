import SwiftUI

struct SearchBarView: View {

    // MARK: - Properties

    @EnvironmentObject private var viewModelFactory: ViewModelFactory
    @State private var searchExpanded = false

    // MARK: - Public

    var body: some View {
        HStack {
            HStack {
                if searchExpanded {
                    SearchTextView(
                        viewModel: viewModelFactory.makeSearchBarViewModel(),
                        action: { withAnimation { searchExpanded.toggle() } }
                    )
                    .transition(.move(edge: .trailing))
                }
            }
            .frame(minWidth: 200, minHeight: 30)

            if !searchExpanded {
                Button(
                    action:  { withAnimation { searchExpanded.toggle() } },
                    label:  { Image(systemName: "magnifyingglass") }
                )
            }
        }
    }
}
