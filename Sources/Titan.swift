@_exported import TitanCore
@_exported import TitanRouter
@_exported import TitanTopLevel

public extension Titan {
  public func get(_ path: String, function: @escaping (inout Request, inout Response) -> Void) {
    self.get(path: path, handler: toFunction(function))
  }

  private func toFunction(_ function: @escaping (inout Request, inout Response) -> Void) -> Function {
    return { req, res in
      var mutRequest = Request(req.method, req.path, req.body, headers: req.headers)
      var mutResponse = Response(res.code, res.body, headers: res.headers)
      function(&mutRequest, &mutResponse)
      return (mutRequest, mutResponse)
    }
  }
}
