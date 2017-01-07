// Generated using Sourcery 0.5.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


public func get(path path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.get(path: path, handler: handler)
}

public func post(path path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.post(path: path, handler: handler)
}

public func put(path path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.put(path: path, handler: handler)
}

public func patch(path path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.patch(path: path, handler: handler)
}

public func delete(path path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.delete(path: path, handler: handler)
}

public func options(path path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.options(path: path, handler: handler)
}

public func head(path path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.head(path: path, handler: handler)
}

public func middleware(_ path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.middleware(path, handler: handler)
}

public func get(_ path: String, handler handler: @escaping (RequestType) -> String) {
  GlobalDefaultTitanInstance.get(path, handler: handler)
}

public func get(_ path: String, handler handler: @escaping () -> String) {
  GlobalDefaultTitanInstance.get(path, handler: handler)
}

public func middleware(_ path: String, handler handler: @escaping () -> ()) {
  GlobalDefaultTitanInstance.middleware(path, handler: handler)
}

public func route(method method: String?, path path: String, handler handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.route(method: method, path: path, handler: handler)
}


