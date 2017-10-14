import Foundation
import TitanCore

public extension RequestType {

    public var queryPairs: [(key: String, value: String)] {

        guard let indexOfQuery = self.path.index(of: "?") else {
            return []
        }

        let query = self.path.suffix(from: indexOfQuery).dropFirst()
        let pairs = query.split(separator: "&")

        return pairs.map { pair -> (key: String, value: String) in
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
