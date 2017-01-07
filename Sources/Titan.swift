@_exported import TitanCore

enum HTTPMethod {
  case GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD
}
internal var GlobalDefaultTitanInstance = Titan()

public private(set) var TitanApp = GlobalDefaultTitanInstance.app

//public func middleware(_ path: String, handler: @escaping Middleware) {
//  GlobalDefaultTitanInstance.middleware(path, handler: handler)
//}
//
//public func get(path: String, handler: @escaping (RequestType) -> String) {
//  GlobalDefaultTitanInstance.get(path: path, handler: toMiddleware(handler))
//}

public func TitanAppReset() {
  GlobalDefaultTitanInstance = Titan()
  TitanApp = GlobalDefaultTitanInstance.app
}
