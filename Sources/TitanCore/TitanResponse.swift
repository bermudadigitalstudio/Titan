import Foundation

public protocol ResponseType {
    /// Status code. We have deliberately eschewed a status line since HTTP/2 ignores it, rarely used.
    var code: Int { get }
    var headers: [Header] { get }
    var body: Data { get }
}

extension ResponseType {
    public var bodyString: String? {
        return String(data: self.body, encoding: .utf8)
    }
    
    public func copy() -> Response {
        return Response(response: self)
    }
}

public struct Response {
    public var code: Int
    public var headers: [Header]
    public var body: Data

    public init(code: Int, body: String, headers: [Header]) throws {
        self.code = code
        guard let data = body.data(using: .utf8) else {
            throw TitanError.dataConversion
        }
        self.body = data
        self.headers = headers
    }

    public init(code: Int, body: Data, headers: [Header]) {
        self.code = code
        self.body = body
        self.headers = headers
    }
}

extension Response: ResponseType {}

extension Response {
    public init(response: ResponseType) {
        self.init(code: response.code, body: response.body, headers: response.headers)
    }
}