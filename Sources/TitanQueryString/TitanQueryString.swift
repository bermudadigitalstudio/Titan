import Foundation
import TitanCore

public extension RequestType {
    /// The pairs of keys and values in the query string of the `RequestType`s path.
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
            let comps = pair.split(separator: "=").map { chars -> String in
                return String(chars).removingPercentEncoding ?? ""
                }.map {
                    return $0.replacingOccurrences(of: "+", with: " ")
            }
            switch comps.count {
            case 1:
                return (key: String(comps[0]), value: "")
            case 2:
                return (key: String(comps[0]), value: String(comps[1]))
            default:
                return (key: "", value: "")
            }
        }
    }

    public var query: [String: String] {
        var query: [String: String] = [:]
        for (name, value) in self.queryPairs {
            query[name] = value
        }
        return query
    }

}
