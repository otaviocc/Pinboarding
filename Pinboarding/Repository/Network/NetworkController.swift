import Combine
import Foundation
import PinboardKit

final class NetworkController: NetworkControllerProtocol {

    // MARK: - Properties

    private var cancellables: Set<AnyCancellable> = []
    private var pinboardAPI: PinboardAPI
    private let postResponseSubject = PassthroughSubject<[PostResponse], Never>()

    // MARK: - Life cycle

    init(
        pinboardAPI: PinboardAPI
    ) {
        self.pinboardAPI = pinboardAPI

        recentBookmarksPublisher
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    self.postResponseSubject.send($0)
                }
            )
            .store(in: &cancellables)
    }

    // MARK: - Public

    func updates() -> AnyPublisher<[PostResponse], Never> {
        postResponseSubject
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private var timerPublisher: AnyPublisher<Date, Never> {
        Timer.TimerPublisher(interval: 15, runLoop: .main, mode: .common)
            .autoconnect()
            .eraseToAnyPublisher()
    }

    private var recentBookmarksPublisher: AnyPublisher<[PostResponse], Error> {
        timerPublisher
            .flatMap { _ in self.pinboardAPI.recents() }
            .map { $0.posts }
            .eraseToAnyPublisher()
    }
}
