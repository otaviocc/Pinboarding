import Combine
import Foundation

final class AddBookmarkViewModel: ObservableObject {

    // MARK: - Properties

    @Published var urlString: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var tags: String = ""
    @Published var isPrivate: Bool = false
    @Published var isToRead: Bool = false
    @Published var suggestions: [String] = []

    @Published private(set) var isValid: Bool = false
    @Published private(set) var urlMessage: String = ""
    @Published private(set) var titleMessage: String = ""
    @Published private(set) var hasSuggestions: Bool = false

    private let repository: PinboardRepository
    private let settingsStore: SettingsStore
    private var cancellables = Set<AnyCancellable>()
    private let dismissViewSubject =
        PassthroughSubject<Bool, Never>()

    // MARK: - Life cycle

    init(
        repository: PinboardRepository,
        settingsStore: SettingsStore
    ) {
        self.repository = repository
        self.settingsStore = settingsStore

        isURLValidPublisher()
            .receive(on: RunLoop.main)
            .map { isValid in
                isValid ? "" : "Invalid URL"
            }
            .assign(to: \.urlMessage, on: self)
            .store(in: &cancellables)

        isTitleValidPublisher()
            .receive(on: RunLoop.main)
            .map { isValid in
                isValid ? "" : "Invalid Title"
            }
            .assign(to: \.titleMessage, on: self)
            .store(in: &cancellables)

        isFormValidPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)

        hasSuggestionsPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.hasSuggestions, on: self)
            .store(in: &cancellables)

        isPrivate = settingsStore.isPrivate
        isToRead = settingsStore.isToRead
    }

    // MARK: - Public

    func addBookmark() async {
        guard
            let url = URL(string: urlString)
        else {
            return
        }

        _ = try? await repository.addBookmark(
            url: url,
            title: title,
            description: description,
            tags: tags,
            shared: !isPrivate,
            toread: isToRead
        )

        DispatchQueue.main.async { [dismissViewSubject] in
            dismissViewSubject.send(true)
        }
    }

    func dismissViewPublisher(
    ) -> AnyPublisher<Bool, Never> {
        dismissViewSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func isURLValidPublisher(
    ) -> AnyPublisher<Bool, Never> {
        $urlString
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { URL(string: $0) != nil }
            .eraseToAnyPublisher()
    }

    private func isTitleValidPublisher(
    ) -> AnyPublisher<Bool, Never> {
        $title
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }

    private func isFormValidPublisher(
    ) -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isURLValidPublisher(), isTitleValidPublisher())
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }

    private func hasSuggestionsPublisher(
    ) -> AnyPublisher<Bool, Never> {
        $suggestions
            .removeDuplicates()
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
}
