import Combine
import CoreData

struct PersistenceObjectFetchPublisher<Model: NSManagedObject>: Publisher {

    // MARK: - Types

    typealias Output = [Model]
    typealias Failure = Error

    // MARK: - Properties

    let request: NSFetchRequest<Model>
    let context: NSManagedObjectContext

    // MARK: - Life cycle

    init(
        request: NSFetchRequest<Model>,
        context: NSManagedObjectContext
    ) {
        self.request = request
        self.context = context
    }

    // MARK: - Public

    func receive<S>(
        subscriber: S
    ) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        subscriber.receive(
            subscription: TransientSubscription(
                subscriber: subscriber,
                fetchRequest: request,
                context: context
            )
        )
    }

    // MARK: - Private

    private typealias TransientSubscriptionProtocol =
        NSObject & Subscription & NSFetchedResultsControllerDelegate

    private final class TransientSubscription<
        S: Subscriber
    >: TransientSubscriptionProtocol where S.Input == [Model], S.Failure == Error {

        // MARK: - Properties

        private let subscriber: S
        private var fetchedResultsController: NSFetchedResultsController<Model>?

        // MARK: - Life cycle

        init(
            subscriber: S,
            fetchRequest: NSFetchRequest<Model>,
            context: NSManagedObjectContext
        ) {
            self.subscriber = subscriber
            self.fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            super.init()

            do {
                try fetchedResultsController?.performFetch()
            } catch {
                subscriber.receive(
                    completion: .failure(error)
                )
            }
        }

        // MARK: - Public

        func request(
            _ demand: Subscribers.Demand
        ) {
            _ = subscriber.receive(
                fetchedResultsController?.fetchedObjects ?? []
            )
        }

        func cancel() {
            fetchedResultsController = nil
        }
    }
}
