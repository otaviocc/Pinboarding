// Pinboard uses a literal yes/no as boolean.

extension String {

    /// Returns `true` for "yes", and `false` for
    /// everything else.
    var booleanValue: Bool {
        self == "yes" ? true : false
    }
}

extension Bool {

    /// Returns "yes" for `true`, and `no` for
    /// everything else.
    var stringValue: String {
        self == true ? "yes" : "no"
    }
}
