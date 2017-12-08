import Foundation

/// A protocol defining an HTTP request
public protocol RequestType {
    /// The HTTP request body.
    var body: Data { get }
    /// The HTTP request path, including query string and any fragments.
    var path: String { get }
    /// The HTTP request method.
    var method: String { get }
    /// The HTTP request headers.
    var headers: [Header] { get }
}

/// A reified `RequestType`
public struct Request: RequestType {
    public var method: String
    public var path: String
    public var body: Data
    public var headers: [Header]

    /// Create a Request
    /// Throws an error if the body parameter cannot be converted to Data
    public init(method: String, path: String, body: String, headers: [Header]) throws {
        self.method = method
        self.path = path
        guard let data = body.data(using: .utf8) else {
            // This is almost certainly impossible.
            throw TitanError.dataConversion
        }
        self.body = data
        self.headers = headers
    }

    /// Create a Request
    public init(method: String, path: String, body: Data, headers: [Header]) {
        self.method = method
        self.path = path
        self.body = body
        self.headers = headers
    }
}

extension Request {
    /// Create a Request from a RequestType
    public init(request: RequestType) {
        self.init(method: request.method, path: request.path, body: request.body, headers: request.headers)
    }
}

extension RequestType {
    /// The HTTP request body as a UTF-8 encoded string.
    public var body: String? {
        return String(data: self.body, encoding: .utf8)
    }
    
    /// Create a Request as a copy of the RequestType
    public func copy() -> Request {
        return Request(request: self)
    }
}
