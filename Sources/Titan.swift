@_exported import TitanCore
@_exported import TitanRouter
@_exported import TitanErrorHandling
@_exported import TitanJSONRequestBody
@_exported import TitanFormURLEncodedBodyParser
@_exported import TitanQueryString
@_exported import Titan404

extension Titan {
  public func predicate(_ predicate: @escaping (RequestType, ResponseType) -> Bool, true trueBuilder: ((Titan) -> Void), false falseBuilder: ((Titan) -> Void)? = nil) {
    let trueTitan = Titan()
    trueBuilder(trueTitan)
    let falseTitan = falseBuilder.map { (builder) -> Titan in
      let falseTitan = Titan()
      builder(falseTitan)
      return falseTitan
    }
    self.addFunction { (req, res) -> (RequestType, ResponseType) in
      if predicate(req, res) {
        return (req, trueTitan.app(request: req))
      } else {
        return (req, falseTitan?.app(request: req) ?? res)
      }
    }
  }

  public func authenticated(_ predicate: @escaping ((RequestType) -> Bool), _ authenticatedBuilder: ((Titan) -> Void)) {
    self.predicate({ (req, res) -> Bool in
      return predicate(req)
    }, true: authenticatedBuilder, false: { (unauthenticated) in
      unauthenticated.addFunction({ (req, res) -> (RequestType, ResponseType) in
        return (req, Response(401, "Not Authorized", [("Content-Type", "text/plain")]))
      })
    })
  }
}
