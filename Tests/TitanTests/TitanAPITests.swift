import XCTest
import Titan

final class TitanAPITests: XCTestCase {
  override func setUp() {
    TitanAppReset()
  }
  func testTitanGet() {
    get("/username") {
      return "swizzlr"
    }
    XCTAssertEqual(TitanApp(Request("GET", "/username")).body, "swizzlr")
  }

  func testTitanEcho() {
    get("/echoMyBody") { req in
      return req.body
    }
    XCTAssertEqual(TitanApp(Request("GET", "/echoMyBody", "hello, this is my body")).body,
                   "hello, this is my body")
  }

  func testMultipleRoutes() {
    get("/username") {
      return "swizzlr"
    }

    get("/echoMyBody") { req in
      return req.body
    }
    XCTAssertEqual(TitanApp(Request("GET", "/echoMyBody", "hello, this is my body")).body,
                   "hello, this is my body")
    XCTAssertEqual(TitanApp(Request("GET", "/username")).body, "swizzlr")
  }

  static var allTests: [(String, (TitanAPITests) -> () throws -> Void)] {
    return [
      ("testTitanGet", testTitanGet),
    ]
  }
}
