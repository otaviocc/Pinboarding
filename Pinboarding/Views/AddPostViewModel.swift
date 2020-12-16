import Combine
import Foundation

final class AddPostViewModel: ObservableObject {
    @Published var urlString: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var tags: String = ""
}
