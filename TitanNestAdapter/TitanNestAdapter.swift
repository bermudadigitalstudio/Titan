import TitanCore
import Nest
import Inquiline

extension Nest.RequestType {
  func toTitanRequest() -> TitanCore.RequestType {
    var body: String
    if var payload = self.body {
      body = payload.toString()
    } else {
      body = ""
    }
    return Request(method, path, body, headers: headers)
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

public func toNestApplication(_ app: @escaping (TitanCore.RequestType) -> (TitanCore.ResponseType)) -> Nest.Application {
  return { req in
    return app(req.toTitanRequest()).toNestResponse()
  }
}

extension Nest.PayloadType {
  mutating func toString() -> String {
    var buffer: [UInt8] = []

    while let n = self.next() {
      buffer += n
    }
    return String(validatingUTF8: buffer.map { Int8($0) }) ?? ""
  }
}
