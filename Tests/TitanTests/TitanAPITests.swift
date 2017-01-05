import XCTest
import Titan

final class TitanAPITests: XCTestCase {
  func testTitanGet() {
    get("/username") {
      return "swizzlr"
    }
    XCTAssertEqual(TitanApp(Request("GET", "/username")), "swizzlr")
  }

  static var allTests: [(String, (TitanAPITests) -> () throws -> Void)] {
    return [
      ("testTitanGet", testTitanGet),
    ]
  }
}
