import Foundation

enum PersistenceControllerEvent {
    case allBookmarks([Bookmark])
    case newBookmarksAdded([Bookmark])
}
