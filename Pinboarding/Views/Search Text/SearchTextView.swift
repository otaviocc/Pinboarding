import SwiftUI

struct SearchTextView: View {

    @ObservedObject private var viewModel: SearchTextViewModel
    @FocusState private var isFocused

    private let action: () -> Void

    // MARK: - Life cycle

    init(
        viewModel: SearchTextViewModel,
        action: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.action = action
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            TextField(
                "Search",
                text: $viewModel.currentSearchTerm
            )
            .focusable(true)
            .focused($isFocused)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(minWidth: 200)
            .onChange(of: isFocused) { newValue in
                if newValue == false && viewModel.currentSearchTerm.isEmpty {
                    action()
                }
            }

            Button(
                action:  {
                    if viewModel.currentSearchTerm.isEmpty {
                        action()
                    }

                    viewModel.clear()
                    isFocused = false
                },
                label:  {
                    Image(systemName: Asset.Action.clear)
                }
            )
            .buttonStyle(BorderlessButtonStyle())
            .frame(width: 20, height: 20)
        }
    }
}
