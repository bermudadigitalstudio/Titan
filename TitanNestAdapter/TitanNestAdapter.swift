import TitanCore
import Nest
import Inquiline // Todo: remove dependency on Inquiline

@available(*, unavailable, message: "Incomplete implementation")
extension Nest.RequestType {
  func toTitanRequest() -> TitanCore.RequestType {
    return Request(method, path)
  }
}

@available(*, unavailable, message: "Incomplete implementation")
extension TitanCore.ResponseType {
  func toNestResponse() -> Nest.ResponseType {
    return Inquiline.Response(Status.accepted)
  }
}

public func toNestApplication(_ app: @escaping (TitanCore.RequestType) -> (TitanCore.ResponseType)) -> Nest.Application {
  return { req in
    return app(req.toTitanRequest()).toNestResponse()
  }
}
