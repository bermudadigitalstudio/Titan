public struct Request {
  public init(_ method: String, _ path: String) {
    self.method = method
    self.path = path
  }
  let method: String
  let path: String
}
public struct Response { }
public final class Titan {
  private var middlewareStack = Array<() -> String>()
  public func get(path: String, handler: @escaping () -> String) {
    middlewareStack.append(handler)
  }
  public func app(request: Request) -> String {
    return middlewareStack.first?() ?? "404"
  }
}
fileprivate let GlobalDefaultTitanInstance = Titan()
public let TitanApp = GlobalDefaultTitanInstance.app

public func get(path: String, handler: @escaping () -> String) {
  GlobalDefaultTitanInstance.get(path: path, handler: handler)
}

public func get(_ path: String, handler: @escaping () -> String) {
  get(path: path, handler: handler)
}

