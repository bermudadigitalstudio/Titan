// Core routes
public extension Titan {
  public func get(path: String, handler: @escaping Middleware) {
    route(method: "GET", path: path, handler: handler)
  }

  public func post(path: String, handler: @escaping Middleware) {
    route(method: "POST", path: path, handler: handler)
  }

  public func put(path: String, handler: @escaping Middleware) {
    route(method: "PUT", path: path, handler: handler)
  }

  public func patch(path: String, handler: @escaping Middleware) {
    route(method: "PATCH", path: path, handler: handler)
  }

  public func delete(path: String, handler: @escaping Middleware) {
    route(method: "DELETE", path: path, handler: handler)
  }

  public func options(path: String, handler: @escaping Middleware) {
    route(method: "OPTIONS", path: path, handler: handler)
  }

  public func head(path: String, handler: @escaping Middleware) {
    route(method: "HEAD", path: path, handler: handler)
  }

  /// Stacks middleware to be handled when matched with a specific path, regardless of method.
  public func middleware(_ path: String, handler: @escaping Middleware) {
    route(path: path, handler: handler)
  }
}

// Syntactic sugars
extension Titan {
  private func toMiddleware(_ handler: @escaping () -> String) -> Middleware {
    return { req, res in
      return (req, Response(200, handler()))
    }
  }
  private func toMiddleware(_ handler: @escaping (RequestType) -> String) -> Middleware {
    return { req, res in
      return (req, Response(200, handler(req)))
    }
  }

  private func toMiddleware(_ handler: @escaping () -> ()) -> Middleware {
    return { req, res in
      handler()
      return (req, res)
    }
  }

  public func get(_ path: String, handler: @escaping (RequestType) -> String) {
    get(path: path, handler: toMiddleware(handler))
  }

  public func get(_ path: String, handler: @escaping () -> String) {
    get(path: path, handler: toMiddleware(handler))
  }

  public func middleware(_ path: String, handler: @escaping () -> ()) {
    middleware(path, handler: toMiddleware(handler))
  }
}


