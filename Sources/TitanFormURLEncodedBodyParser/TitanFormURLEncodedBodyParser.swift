import Foundation
import TitanCore

public extension RequestType {

    public var formURLEncodedBody: [(name: String, value: String)] {
        guard let bodyString = self.bodyString else {
            return []
        }

        return parse(body: bodyString)
    }

    public var postParams: [String: String] {
        var ret = [String: String]()
        guard let bodyString = self.bodyString else {
            return ret
        }
        let keys = parse(body: bodyString)
        for (k, v) in keys {
            ret[k] = v
        }
        return ret
    }
}

/*
 Parse application/x-www-form-urlencoded bodies
 Returns as many name-value pairs as possible
 Liberal in what it accepts, any failures to delimit pairs or decode percent
 encoding will result in empty strings
 */
func parse(body: String) -> [(name: String, value: String)] {
    var retValue = [(name: String, value: String)]()

    let pairs = body.components(separatedBy: "&") // Separate the tuples

    for element in pairs {
        guard let range = element.range(of: "=") else {
            return retValue
        }

        let rawKey = element[..<range.lowerBound]
        let rawValue = element[range.upperBound...]

        // Remove + character
        let sanitizedKey = String(rawKey).replacingOccurrences(of: "+", with: " ")
        let sanitizedPlus = String(rawValue).replacingOccurrences(of: "+", with: " ")

        // Remove percent encoding characters
        if let sanitizedValue = sanitizedPlus.removingPercentEncoding {
            retValue.append((sanitizedKey, sanitizedValue))
        } else {
            retValue.append((sanitizedKey, sanitizedPlus))
        }
    }
    return retValue
}
