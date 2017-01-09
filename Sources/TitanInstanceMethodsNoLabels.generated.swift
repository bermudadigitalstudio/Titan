// Routing methods for Titan overloaded with no labels
extension Titan {
  
  public func get(_ path: String, _ handler: @escaping Middleware) {
    get(path: path, handler: handler)
  }
  
  public func post(_ path: String, _ handler: @escaping Middleware) {
    post(path: path, handler: handler)
  }
  
  public func put(_ path: String, _ handler: @escaping Middleware) {
    put(path: path, handler: handler)
  }
  
  public func patch(_ path: String, _ handler: @escaping Middleware) {
    patch(path: path, handler: handler)
  }
  
  public func delete(_ path: String, _ handler: @escaping Middleware) {
    delete(path: path, handler: handler)
  }
  
  public func options(_ path: String, _ handler: @escaping Middleware) {
    options(path: path, handler: handler)
  }
  
  public func head(_ path: String, _ handler: @escaping Middleware) {
    head(path: path, handler: handler)
  }
  
  public func route(_ path: String, _ handler: @escaping Middleware) {
    route(path: path, handler: handler)
  }
  
}
