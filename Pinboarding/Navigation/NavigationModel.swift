import Foundation

final class NavigationModel: ObservableObject {
     @Published var path: NavigationDestination = .all
}
