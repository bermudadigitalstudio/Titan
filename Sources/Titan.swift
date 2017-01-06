@_exported import TitanCore

private var GlobalDefaultTitanInstance = Titan()

public private(set) var TitanApp = GlobalDefaultTitanInstance.app

public func get(path: String, handler: @escaping (RequestType) -> String) {
  GlobalDefaultTitanInstance.get(path: path, handler: toMiddleware(handler))
}

private func toMiddleware(_ handler: @escaping (RequestType) -> String) -> Middleware {
  return { req, res in
    return (req, Response(200, handler(req)))
  }
}

public func get(_ path: String, handler: @escaping (RequestType) -> String) {
  get(path: path, handler: handler)
}

public func get(_ path: String, handler: @escaping () -> String) {
  get(path: path, handler: { _ in handler() } )
}

public func TitanAppReset() {
  GlobalDefaultTitanInstance = Titan()
  TitanApp = GlobalDefaultTitanInstance.app
}
