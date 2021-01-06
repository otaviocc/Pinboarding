import SwiftUI

struct AddBookmarkView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: AddBookmarkViewModel
    @Binding private var isPresented: Bool

    // MARK: - Life cycle

    init(
        viewModel: AddBookmarkViewModel,
        isPresented: Binding<Bool>
    ) {
        self.viewModel = viewModel
        self._isPresented = isPresented
    }

    // MARK: - Public

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("URL")
            TextField("", text: $viewModel.urlString)

            Text("Title")
            TextField("", text: $viewModel.title)

            Text("Description")
            TextEditor(text: $viewModel.description)
                .frame(height: 100)

            Text("Tags")
            TextField("", text: $viewModel.tags)

            makeTogglesView()
                .padding(.top)

            makeButtonsView()
        }
        .padding()
        .onReceive(viewModel.dismissViewPublisher()) { _ in
            isPresented.toggle()
        }
    }

    // MARK: - Private

    private func makeTogglesView(
    ) -> some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Toggle("Private", isOn: $viewModel.isPrivate)
                    .toggleStyle(SwitchToggleStyle())

                Toggle("Read later", isOn: $viewModel.isToRead)
                    .toggleStyle(SwitchToggleStyle())
            }
        }
    }

    private func makeButtonsView(
    ) -> some View {
        HStack {
            Button("Cancel") {
                isPresented.toggle()
            }
            .padding()

            Spacer()

            Button("Add bookmark") {
                viewModel.addBookmark()
            }
            .disabled(!viewModel.isValid)
        }
    }
}

// MARK: - PreviewProvider

struct AddBookmarkView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            AddBookmarkView(
                viewModel: AddBookmarkViewModel(
                    repository: Preview.makeRepository(),
                    settingsStore: Preview.makeSettingsStore()
                ),
                isPresented: .constant(false)
            )
            .frame(width: 640)
            .preferredColorScheme(.light)

            AddBookmarkView(
                viewModel: AddBookmarkViewModel(
                    repository: Preview.makeRepository(),
                    settingsStore: Preview.makeSettingsStore()
                ),
                isPresented: .constant(false)
            )
            .preferredColorScheme(.dark)
        }
        .frame(width: 640)
        .previewLayout(.sizeThatFits)
    }
}
