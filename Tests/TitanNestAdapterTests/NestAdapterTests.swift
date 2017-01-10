import TitanNestAdapter
import TitanCore
import Nest
import Inquiline
import XCTest

final class TitanAPITests: XCTestCase {
  var titanInstance: Titan!
  override func setUp() {
    titanInstance = Titan()
  }

  func testConvertingNestRequestToTitanRequest() {
    let req = Inquiline.Request(method: "PATCH",
                                path: "/complexPath/with/comps?query=string&value=stuff",
                                headers: [("Accept", "application/json")],
                                content: "Some body goes here")
    var nestRequest: TitanCore.RequestType!
    titanInstance.middleware { (request, response) -> (TitanCore.RequestType, TitanCore.ResponseType) in
      nestRequest = request
      return (request, response)
    }
    let app = toNestApplication(titanInstance.app)
    let _ = app(req)
    XCTAssertNotNil(nestRequest)
    XCTAssertEqual(nestRequest.path, "/complexPath/with/comps?query=string&value=stuff")
    XCTAssertEqual(nestRequest.body, "Some body goes here")
    XCTAssertEqual(nestRequest.method, "PATCH")
    XCTAssertEqual(nestRequest.headers.first?.0, "Accept")
    XCTAssertEqual(nestRequest.headers.first?.1, "application/json")
  }
}
