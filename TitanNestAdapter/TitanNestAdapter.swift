import TitanCore
import Nest
import Inquiline

extension Nest.RequestType {
  func toTitanRequest() -> TitanCore.RequestType {
    return Request(method, path, self.content ?? "", headers: headers)
  }
}

extension TitanCore.ResponseType {
  func toNestResponse() -> Nest.ResponseType {
    guard let status = Status(rawValue: self.code) else { // Todo: this is a bit fragile – remove the inquiline dependency!
      return Inquiline.Response(Status.badGateway, content: "Titan Nest Adapter could not parse the response from Titan")
    }
    return Inquiline.Response(status, headers: self.headers, content: self.body)
  }
}

/// When using TitanNestAdapter, a Content-Length header MUST be provided if the request has a body. Encoding is assumed to be utf-8.
public func toNestApplication(_ app: @escaping (TitanCore.RequestType) -> (TitanCore.ResponseType)) -> Nest.Application {
  return { req in
    return app(req.toTitanRequest()).toNestResponse()
  }
}
