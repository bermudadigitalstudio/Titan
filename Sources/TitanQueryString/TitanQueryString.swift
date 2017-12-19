import Foundation
import TitanCore

public extension RequestType {
    /// The pairs of keys and values in the query string of the `RequestType`s path.
    /// Complexity: 0(n) on all invocations.
    public var queryPairs: [(key: String, value: String)] {
        // Ensure there is a query string, otherwise return
        guard let indexOfQuery = self.path.index(of: "?") else {
            return []
        }

        let query = self.path.suffix(from: indexOfQuery).dropFirst()
        // Create an array of the individual query pairs, e.g. ["foo=bar", "baz=qux"]
        let pairs = query.split(separator: "&")

        // Decode `foo=bar` -> `(key: "foo", value: "bar")`, percent decoding any values along the way
        return pairs.map { pair -> (key: String, value: String) in
            // Separate the query pair into an array, e.g. "foo=bar" -> ["foo", "bar"]
            let comps = pair.split(separator: "=")
                // Split returns an array of subsequences which should conform to StringProtocol, however on Linux StringProtocol is out of date.
                // Workaround for https://bugs.swift.org/browse/SR-5727 by converting to a String directly
                .map(String.init)
                .map {
                    // Percent encoding mandates that "%20" = <space>" – however, many applications use "+" to mean space as well, so decode those (before we decode any percent-encoded plus signs!)
                    return $0.replacingOccurrences(of: "+", with: " ")
                }.map {
                    return $0.removingPercentEncoding ?? ""
                }
            switch comps.count {
            case 1: // "?foo="
                return (key: String(comps[0]), value: "")
            case 2: // "?foo=bar"
                return (key: String(comps[0]), value: String(comps[1]))
            default: // "?"
                return (key: "", value: "")
            }
        }
    }

    /// Access the query string as a dictionary, with case sensitive keys.
    /// Complexity: 0(n) on all invocations.
    public var query: [String: String] {
        var query: [String: String] = [:]
        for (name, value) in self.queryPairs {
            query[name] = value
        }
        return query
    }
}
