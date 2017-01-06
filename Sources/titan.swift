public struct Request {
  public init(_ method: String, _ path: String, _ body: String = "") {
    self.method = method
    self.path = path
    self.body = body
  }
  public let method: String
  public let path: String
  public let body: String
}

public protocol RequestType {
  var body: String { get }
  var path: String { get }
  var method: String { get }
}

public protocol ResponseType {
  var body: String { get }
}

public struct Response {
  let code: Int
  public let body: String
  let encoding: Encoding = .utf8
  enum Encoding {
    case utf8, utf16
  }
}

public func TitanAppReset() {
  GlobalDefaultTitanInstance = Titan()
  TitanApp = GlobalDefaultTitanInstance.app
}

extension Response: ResponseType {}

extension Request: RequestType {}

public typealias Middleware = (RequestType, ResponseType) -> (RequestType, ResponseType)
public final class Titan {
  private var middlewareStack = Array<Middleware>()
  public func get(path: String, handler: @escaping Middleware) {
    route(method: "GET", path: path, handler: handler)
  }

  func route(method: String, path: String, handler: @escaping Middleware) {
    let routeWare: Middleware = { (req, res) in
      guard req.path == path && req.method == method else {
        return (req, Response(code: 404, body: ""))
      }
      return handler(req, res)
    }
    middlewareStack.append(routeWare)
  }

  public func app(request: Request) -> ResponseType {
    typealias Result = (RequestType, ResponseType)

    let initialReq = Request("", "")
    let initialRes = Response(code: 0, body: "")
    let initial: Result = (initialReq, initialRes)
    let res = middlewareStack.reduce(initial) { (res, next) -> Result in
      return next(res.0, res.1)
    }
    return res.1
  }
}

fileprivate var GlobalDefaultTitanInstance = Titan()
public private(set) var TitanApp = GlobalDefaultTitanInstance.app

public func get(path: String, handler: @escaping (RequestType) -> String) {
  GlobalDefaultTitanInstance.get(path: path, handler: toMiddleware(handler))
}

private func toMiddleware(_ handler: @escaping (RequestType) -> String) -> Middleware {
  return { req, res in
    return (req, Response(code: 200, body: handler(req)))
  }
}

public func get(_ path: String, handler: @escaping (RequestType) -> String) {
  get(path: path, handler: handler)
}

public func get(_ path: String, handler: @escaping () -> String) {
  get(path: path, handler: { _ in handler() } )
}

