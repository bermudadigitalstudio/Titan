import Foundation

public protocol RequestType {
    var body: Data { get }
    var path: String { get }
    var method: String { get }
    var headers: [Header] { get }
}

extension RequestType {
    public var bodyString: String? {
        return String(data: self.body, encoding: .utf8)
    }

    public func copy() -> Request {
        return Request(request: self)
    }
}

public struct Request {
    public var method: String
    public var path: String
    public var body: Data
    public var headers: [Header]

    public init(method: String, path: String, body: String, headers: [Header]) throws {
        self.method = method
        self.path = path
        guard let data = body.data(using: .utf8) else {
            throw TitanError.dataConversion
        }
        self.body = data
        self.headers = headers
    }

    public init(method: String, path: String, body: Data, headers: [Header]) {
        self.method = method
        self.path = path
        self.body = body
        self.headers = headers
    }
}

extension Request: RequestType {}

extension Request {
    public init(request: RequestType) {
        self.init(method: request.method, path: request.path, body: request.body, headers: request.headers)
    }
}
