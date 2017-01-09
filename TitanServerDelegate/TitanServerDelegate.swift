import TitanCore
import KituraNet

@available(*, unavailable, message: "Incomplete implementation")
public final class TitanServerDelegate: ServerDelegate {
  let app: (RequestType) -> (ResponseType)
  public init(_ titanApp: @escaping (RequestType) -> (ResponseType)) {
    self.app = titanApp
  }
  public func handle(request: ServerRequest, response: ServerResponse) {
    let r = self.app(request.toRequest())
    try? r.writeToServerResponse(response)
  }
}

@available(*, unavailable, message: "Incomplete implementation")
extension ServerRequest {
  func toRequest() -> Request {
    return Request(self.method, "")
  }
}

@available(*, unavailable, message: "Incomplete implementation")
extension ResponseType {
  func writeToServerResponse(_ response: ServerResponse) throws {
    response.statusCode = HTTPStatusCode(rawValue: code)
    try response.end(text: body)
  }
}
