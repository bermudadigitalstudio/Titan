// Routing methods for Titan overloaded with no labels
extension Titan {
  
  public func get(path: String, _ handler: @escaping (RequestType) -> String) {
    self.get(path, handler: handler)
  }

  public func get(path: String, _ handler: @escaping () -> String) {
    self.get(path, handler: handler)
  }

  public func middleware(path: String, _ handler: @escaping () -> ()) {
    self.middleware(path, handler: handler)
  }

  public func get(_ path: String, _ handler: @escaping Middleware) {
    self.get(path: path, handler: handler)
  }

  public func post(_ path: String, _ handler: @escaping Middleware) {
    self.post(path: path, handler: handler)
  }

  public func put(_ path: String, _ handler: @escaping Middleware) {
    self.put(path: path, handler: handler)
  }

  public func patch(_ path: String, _ handler: @escaping Middleware) {
    self.patch(path: path, handler: handler)
  }

  public func delete(_ path: String, _ handler: @escaping Middleware) {
    self.delete(path: path, handler: handler)
  }

  public func options(_ path: String, _ handler: @escaping Middleware) {
    self.options(path: path, handler: handler)
  }

  public func head(_ path: String, _ handler: @escaping Middleware) {
    self.head(path: path, handler: handler)
  }

  public func route(_ method: String?, _ path: String, _ handler: @escaping Middleware) {
    self.route(method: method, path: path, handler: handler)
  }

  public func middleware(_ path: String, _ handler: @escaping Middleware) {
    self.middleware(path: path, handler: handler)
  }

}
