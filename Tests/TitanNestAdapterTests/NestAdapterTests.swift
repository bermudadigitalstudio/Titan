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
    var titanRequestConvertedFromNest: TitanCore.RequestType!
    titanInstance.middleware { (request, response) -> (TitanCore.RequestType, TitanCore.ResponseType) in
      titanRequestConvertedFromNest = request
      return (request, response)
    }
    let app = toNestApplication(titanInstance.app)
    let _ = app(req)
    XCTAssertNotNil(titanRequestConvertedFromNest)
    XCTAssertEqual(titanRequestConvertedFromNest.path, "/complexPath/with/comps?query=string&value=stuff")
    XCTAssertEqual(titanRequestConvertedFromNest.body, "Some body goes here")
    XCTAssertEqual(titanRequestConvertedFromNest.method, "PATCH")
    XCTAssertEqual(titanRequestConvertedFromNest.headers.first?.0, "Accept")
    XCTAssertEqual(titanRequestConvertedFromNest.headers.first?.1, "application/json")
  }

  func testConvertingTitanResponseToNestResponse() {
    let titanResponse = TitanCore.Response(501, "Not implemented; developer is exceedingly lazy", headers: [("Cache-Control", "private")])
    let nestResponseConvertedFromTitan: Nest.ResponseType
    titanInstance.middleware { (request, response) -> (TitanCore.RequestType, TitanCore.ResponseType) in
      return (request, titanResponse)
    }
    let app = toNestApplication(titanInstance.app)
    let request = Inquiline.Request(method: "GET", path: "/")
    nestResponseConvertedFromTitan = app(request)
    XCTAssertNotNil(nestResponseConvertedFromTitan.body)
    XCTAssertTrue(nestResponseConvertedFromTitan.statusLine.hasPrefix("501"))
    XCTAssertEqual(nestResponseConvertedFromTitan.headers.count, 1)
    XCTAssertEqual(nestResponseConvertedFromTitan.headers.first?.0, "Cache-Control")
    XCTAssertEqual(nestResponseConvertedFromTitan.headers.first?.1, "private")
  }
}
