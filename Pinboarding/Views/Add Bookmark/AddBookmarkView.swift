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

            Text("Tags")
            TextField("", text: $viewModel.tags)

            HStack {
                Button("Cancel") {
                    isPresented.toggle()
                }
                .padding()

                Spacer()

                Button("Add") {
                    viewModel.save()
                }
                .disabled(!viewModel.isValid)
                .padding()
            }
        }
        .padding()
        .onReceive(viewModel.dismissViewPublisher()) { _ in
            isPresented.toggle()
        }
    }
}

// MARK: - PreviewProvider

struct AddBookmarkView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            AddBookmarkView(
                viewModel: AddBookmarkViewModel(
                    repository: Preview.makeRepository()
                ),
                isPresented: .constant(false)
            )
            .frame(width: 320)
            .preferredColorScheme(.light)

            AddBookmarkView(
                viewModel: AddBookmarkViewModel(
                    repository: Preview.makeRepository()
                ),
                isPresented: .constant(false)
            )
            .frame(width: 320)
            .preferredColorScheme(.dark)
        }
    }
}
