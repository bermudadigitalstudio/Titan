import Foundation
import TitanCore

public extension Response {

    public init(code: Int, json: Any) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            self.init(code: code, body: jsonData, headers: [("content-type", "application/json")])
        } catch {
            self.init(code: 500, body: Data(), headers: [])
        }
    }

    public init<T: Encodable>(code: Int, object: T, jsonEncoder: JSONEncoder = JSONEncoder()) {
        do {
            let data = try jsonEncoder.encode(object)
            self.init(code: code, body: data, headers: [("content-type", "application/json")])
        } catch {
            self.init(code: 500, body: Data(), headers: [])
        }
    }
}
