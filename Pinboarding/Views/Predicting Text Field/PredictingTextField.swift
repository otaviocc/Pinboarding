import SwiftUI
import Combine

struct PredictingTextField: View {

    // MARK: - Properties

    @Binding private var text: String
    @Binding private var predictions: [String]

    private let title: String
    private var reference: [String] = []
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Life cycle

    /// Creates a text field with a text label generated from a title string
    ///
    /// - Parameters:
    ///   - title: The title of the text view, describing its purpose.
    ///   - reference: The list of words used to match against.
    ///   - text: The text to display and edit.
    ///   - predictions: The list of words matching the list of valid words.
    init(
        _ title: String = "",
        reference: [String],
        text: Binding<String>,
        predictions: Binding<[String]>
    ) {
        self.title = title
        self.reference = reference
        self._text = text
        self._predictions = predictions

        matchingPredictionsPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.predictions, on: self)
            .store(in: &cancellables)
    }

    // MARK: - Public

    var body: some View {
        TextField(title, text: $text)
    }

    // MARK: - Private

    private func matchingPredictionsPublisher(
    ) -> AnyPublisher<[String], Never> {
        guard
            text.last != " ",
            !text.isEmpty
        else {
            return Just([]).eraseToAnyPublisher()
        }

        return text
            .split(separator: " ")
            .last
            .publisher
            .map { lastWord in
                reference.filter { word in
                    word.lowercased().contains(lastWord.lowercased())
                }
            }
            .eraseToAnyPublisher()
    }
}
