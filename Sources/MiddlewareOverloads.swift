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
    middleware(path: path, handler: toMiddleware(handler))
  }
}
