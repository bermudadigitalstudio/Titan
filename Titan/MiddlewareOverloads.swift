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

  private func toMiddleware(_ handler: @escaping (RequestType) -> Int) -> Middleware {
    return { req, res in
      return (req, Response(handler(req), ""))
    }
  }

  public func get(_ path: String, handler: @escaping (RequestType) -> String) {
    get(path: path, handler: toMiddleware(handler))
  }

  public func post(_ path: String, handler: @escaping (RequestType) -> Int) {
    post(path: path, handler: toMiddleware(handler))
  }

  public func get(_ path: String, handler: @escaping () -> String) {
    get(path: path, handler: toMiddleware(handler))
  }

  public func options(_ path: String, handler: @escaping () -> String) {
    options(path: path, handler: toMiddleware(handler))
  }

  public func post(_ path: String, handler: @escaping () -> String) {
    post(path: path, handler: toMiddleware(handler))
  }

  public func patch(_ path: String, handler: @escaping () -> String) {
    patch(path: path, handler: toMiddleware(handler))
  }

  public func put(_ path: String, handler: @escaping () -> String) {
    put(path: path, handler: toMiddleware(handler))
  }

  public func delete(_ path: String, handler: @escaping () -> String) {
    delete(path: path, handler: toMiddleware(handler))
  }

  public func head(_ path: String, handler: @escaping () -> String) {
    head(path: path, handler: toMiddleware(handler))
  }

  public func middleware(_ path: String, handler: @escaping () -> ()) {
    middleware(path: path, handler: toMiddleware(handler))
  }
}
