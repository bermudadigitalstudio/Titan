import Foundation

/// A protocol defining an HTTP response
public protocol ResponseType {
    /// The HTTP response status code.
    var code: Int { get }
    /// The HTTP response headers.
    var headers: [Header] { get }
    /// The HTTP response body.
    var body: Data { get }
}

/// A reified `ResponseType`
public struct Response: ResponseType {
    public var code: Int
    public var headers: [Header]
    public var body: Data

    /// Create a Response
    /// Throws an error if the body parameter cannot be converted to Data
    public init(code: Int, body: String, headers: [Header]) throws {
        self.code = code
        guard let data = body.data(using: .utf8) else {
            // I don't see how this could ever happen.
            throw TitanError.dataConversion
        }
        self.body = data
        self.headers = headers
    }

    /// Create a Response
    public init(code: Int, body: Data, headers: [Header]) {
        self.code = code
        self.body = body
        self.headers = headers
    }
}

extension Response {
    /// Create a Response from a ResponseType
    public init(response: ResponseType) {
        self.init(code: response.code, body: response.body, headers: response.headers)
    }
}

extension ResponseType {
    /// The HTTP response body as a UTF-8 encoded string.
    public var body: String? {
        return String(data: self.body, encoding: .utf8)
    }
    /// Create a Response as a copy of the ResponseType
    public func copy() -> Response {
        return Response(response: self)
    }
}
