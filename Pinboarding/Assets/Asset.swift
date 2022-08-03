enum Asset {

    enum Lock {
        static let closed = "lock"
        static let open = "lock.open"
    }

    enum QRCode {
        static let icon = "qrcode"
        static let placeholder = "square.dashed"
    }

    enum Action {
        static let add = "plus"
        static let refresh = "arrow.clockwise"
        static let share = "square.and.arrow.up"
        static let open = "safari"
        static let clear = "xmark.circle.fill"
        static let bookmark = "bookmark"
    }

    enum Bookmark {
        static let all = "bookmark"
        static let `public` = "person.2"
        static let `private` = "lock"
        static let unread = "envelope.badge"
    }

    enum Connection {
        static let online = "cloud"
        static let offline = "exclamationmark.triangle"
    }

    enum Tag {
        static let icon = "tag"
    }

    enum Warning {
        static let exclamation = "exclamationmark.triangle"
    }
}
