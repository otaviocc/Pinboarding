import Foundation

final class NavigationStore: ObservableObject {
     @Published var selection: NavigationDestination = .all
}
