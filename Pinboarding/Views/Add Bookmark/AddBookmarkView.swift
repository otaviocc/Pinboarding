import SwiftUI

struct AddBookmarkView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: AddBookmarkViewModel

    // MARK: - Life cycle

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
                Button("Cancel") {}
                    .padding()

                Spacer()

                Button("Add") {}
                    .padding()
            }
        }
        .padding()
    }
}

// MARK: - PreviewProvider

struct AddBookmarkView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            AddBookmarkView(
                viewModel: AddBookmarkViewModel()
            )
            .preferredColorScheme(.light)

            AddBookmarkView(
                viewModel: AddBookmarkViewModel()
            )
            .preferredColorScheme(.dark)
        }
    }
}
