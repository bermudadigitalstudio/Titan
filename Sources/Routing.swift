extension Titan {

  public func get(path: String, handler: @escaping Middleware) {
    route(method: "GET", path: path, handler: handler)
  }

  private func route(method: String? = nil, path: String, handler: @escaping Middleware) {
    let routeWare: Middleware = { (req, res) in
      if let m = method, m.uppercased() != req.method.uppercased() {
        return (req, res)
      }
      guard matchRoute(path: req.path, route: path) else {
        return (req, res)
      }
      return handler(req, res)
    }
    middleware(middleware: routeWare)
  }

  public func middleware(_ path: String, handler: @escaping Middleware) {
    route(path: path, handler: handler)
  }
}

private func matchRoute(path: String, route: String) -> Bool {
  guard route != "*" else { return true }
  return path == route
}
