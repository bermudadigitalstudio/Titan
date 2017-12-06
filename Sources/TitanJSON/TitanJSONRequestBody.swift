import TitanCore
import Foundation

public extension RequestType {
    /// Return the body content as a JSON object, if possible, otherwise return nil.
    /// Uses `Foundation` JSONSerialization for decoding.
    var json: Any? {
        return try? JSONSerialization.jsonObject(with: body, options: [])
    }
}
