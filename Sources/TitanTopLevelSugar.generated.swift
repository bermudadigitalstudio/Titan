// Generated using Sourcery 0.5.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


public func get(path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.get(path: path, handler: handler)
}

public func post(path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.post(path: path, handler: handler)
}

public func put(path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.put(path: path, handler: handler)
}

public func patch(path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.patch(path: path, handler: handler)
}

public func delete(path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.delete(path: path, handler: handler)
}

public func options(path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.options(path: path, handler: handler)
}

public func head(path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.head(path: path, handler: handler)
}

public func middleware(path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.middleware(path, handler: handler)
}

public func get(path: String, handler: @escaping (RequestType) -> String) {
  GlobalDefaultTitanInstance.get(path, handler: handler)
}

public func get(path: String, handler: @escaping () -> String) {
  GlobalDefaultTitanInstance.get(path, handler: handler)
}

public func middleware(path: String, handler: @escaping () -> ()) {
  GlobalDefaultTitanInstance.middleware(path, handler: handler)
}

public func route(method: String?, path: String, handler: @escaping Middleware) {
  GlobalDefaultTitanInstance.route(method: method, path: path, handler: handler)
}


