import Combine
import Foundation

final class AddBookmarkViewModel: ObservableObject {

    // MARK: - Properties

    @Published var urlString: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var tags: String = ""

    @Published private(set) var isValid: Bool = false
    @Published private(set) var urlMessage: String = ""
    @Published private(set) var titleMessage: String = ""

    private let repository: PinboardRepository
    private var cancellables = Set<AnyCancellable>()
    private let dismissalViewSubject = PassthroughSubject<Bool, Never>()

    // MARK: - Life cycle

    init(
        repository: PinboardRepository
    ) {
        self.repository = repository

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
    }

    // MARK: - Public

    func save() {
        guard
            let url = URL(string: urlString)
        else {
            return
        }

        repository.addBookmark(
            url: url,
            title: title,
            description: description,
            tags: tags
        )
        .sink(
            receiveCompletion: { _ in },
            receiveValue: { _ in
                self.dismissalViewSubject.send(true)
            }
        )
        .store(in: &cancellables)
    }

    func dismissalViewPublisher(
    ) -> AnyPublisher<Bool, Never> {
        dismissalViewSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func isURLValidPublisher(
    ) -> AnyPublisher<Bool, Never> {
        $urlString
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { URL(string: $0) != nil }
            .eraseToAnyPublisher()
    }

    private func isTitleValidPublisher(
    ) -> AnyPublisher<Bool, Never> {
        $title
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count > 0 }
            .eraseToAnyPublisher()
    }

    private func isFormValidPublisher(
    ) -> AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isURLValidPublisher(), isTitleValidPublisher())
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
}
