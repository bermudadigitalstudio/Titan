import Foundation
import TitanCore

public extension Response {

    public init(code: Int, json: Any) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        self.init(code: code, body: jsonData, headers: [("content-type", "application/json")])
    }

    public init<T: Encodable>(code: Int, object: T, jsonEncoder: JSONEncoder = JSONEncoder()) throws {
        let data = try jsonEncoder.encode(object)
        self.init(code: code, body: data, headers: [("content-type", "application/json")])
    }
}
