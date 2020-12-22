import Combine
import CoreData

extension NSManagedObjectContext {

    func fetchPublisher<Model: NSManagedObject>(
        request: NSFetchRequest<Model>
    ) -> PersistenceObjectFetchPublisher<Model> {
        PersistenceObjectFetchPublisher(
            request: request,
            context: self
        )
    }
}
