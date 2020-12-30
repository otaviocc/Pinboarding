import Combine
import Foundation
import PinboardKit

final class NetworkController {

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()
    private var pinboardAPI: PinboardAPI
    private let postResponseSubject =
        PassthroughSubject<[PostResponse], Never>()

    // MARK: - Life cycle

    init(
        settingsStore: SettingsStore
    ) {
        self.pinboardAPI = PinboardAPI {
            settingsStore.authToken
        }

        recentBookmarksPublisher()
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

    func updatesPublisher(
    ) -> AnyPublisher<[PostResponse], Never> {
        postResponseSubject
            .eraseToAnyPublisher()
    }

    func eventPublisher(
    ) -> AnyPublisher<NetworkControllerEvent, Never> {
        pinboardAPI.eventPublisher()
            .map { event in
                switch event {
                case .loading:
                    return .loading
                case .finishedLoading:
                    return .finishedLoading
                }
            }
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func timerPublisher(
    ) -> AnyPublisher<Date, Never> {
        Deferred {
            Just(Date())
        }
        .append(
            Timer.TimerPublisher(
                interval: 15,
                runLoop: .main,
                mode: .common
            )
            .autoconnect()
        )
        .eraseToAnyPublisher()
    }

    private func recentBookmarksPublisher(
    ) -> AnyPublisher<[PostResponse], Error> {
        timerPublisher()
            .flatMap { _ in self.pinboardAPI.all() }
            .eraseToAnyPublisher()
    }
}
