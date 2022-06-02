import SwiftUI

struct AddBookmarkView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel: AddBookmarkViewModel

    @Environment(\.presentationMode)
    var presentationMode

    @Environment(\.managedObjectContext)
    private var viewContext

    @FetchRequest(entity: Tag.entity(), sortDescriptors: [.makeSortByNameAscending()])
    private var tags: FetchedResults<Tag>

    // MARK: - Life cycle

    init(
        viewModel: AddBookmarkViewModel
    ) {
        self.viewModel = viewModel
    }

    // MARK: - Public

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            makeInputView()

            HStack(alignment: .top) {
                makeSuggestionsView()
                Spacer()
                makeTogglesView()
            }
            .padding([.top, .bottom])

            makeButtonsView()
        }
        .padding()
        .onReceive(viewModel.dismissViewPublisher()) { _ in
            presentationMode.wrappedValue.dismiss()
        }
    }

    // MARK: - Private

    private func makeInputView(
    ) -> some View {
        Group {
            Text("URL")
            TextField("", text: $viewModel.urlString)

            Text("Title")
            TextField("", text: $viewModel.title)

            Text("Description")
            TextEditor(text: $viewModel.description)
                .frame(height: 100)

            Text("Tags")
            PredictingTextField(
                reference: tags.map(\.name),
                text: $viewModel.tags,
                predictions: $viewModel.suggestions
            )
        }
    }

    @ViewBuilder
    private func makeSuggestionsView(
    ) -> some View {
        if viewModel.hasSuggestions {
            Text(viewModel.suggestions.joined(separator: " "))
        }
    }

    private func makeTogglesView(
    ) -> some View {
        VStack(alignment: .trailing) {
            Toggle("Private", isOn: $viewModel.isPrivate)
                .toggleStyle(SwitchToggleStyle())

            Toggle("Read later", isOn: $viewModel.isToRead)
                .toggleStyle(SwitchToggleStyle())
        }
    }

    private func makeButtonsView(
    ) -> some View {
        HStack {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
            Button("Add bookmark") {
                Task {
                    await viewModel.addBookmark()
                }
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
                    repository: previewAppEnvironment.repository,
                    settingsStore: previewAppEnvironment.settingsStore
                )
            )
            .frame(width: 640)
            .preferredColorScheme(.light)

            AddBookmarkView(
                viewModel: AddBookmarkViewModel(
                    repository: previewAppEnvironment.repository,
                    settingsStore: previewAppEnvironment.settingsStore
                )
            )
            .preferredColorScheme(.dark)
        }
        .frame(width: 640)
        .previewLayout(.sizeThatFits)
    }
}
