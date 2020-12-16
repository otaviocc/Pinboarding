import SwiftUI

struct AddPostView: View {

    // MARK: - Properties

     @ObservedObject var viewModel: AddPostViewModel

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
                Spacer()
                Button("Add") {}
                    .padding()
            }
        }
        .padding()
    }

    // MARK: - Private
}

// MARK: - PreviewProvider

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddPostView(
                viewModel: AddPostViewModel()
            )
            .preferredColorScheme(.light)

            AddPostView(
                viewModel: AddPostViewModel()
            )
            .preferredColorScheme(.dark)
        }
    }
}
