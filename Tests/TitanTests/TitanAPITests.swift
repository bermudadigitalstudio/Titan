import XCTest
import Titan

final class TitanAPITests: XCTestCase {
  override func setUp() {
    TitanAppReset()
  }
  func testMutableParams() {
    let app = Titan()
    app.get("/init") { (req, res) -> Void in
      res.body = "Hello World"
      req.path = "/rewritten"
      res.code = 500
    }
    app.addFunction { (req, res) -> (RequestType, ResponseType) in
      XCTAssertEqual(req.path, "/rewritten")
      return (req, res)
    }
    let response = app.app(request: Request("GET", "/init"))
    XCTAssertEqual(response.code, 500)
    XCTAssertEqual(response.body, "Hello World")
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

  func testTitanSugar() {
    let somePremadeFunction: Function = { req, res in
      return (req, res)
    }
    get(path: "/username", handler: somePremadeFunction)
    get("/username", somePremadeFunction)
  }

  func testFunctionFunction() {
    var start = Date()
    var end = start
    addFunction("*") {
      start = Date()
    }
    get("/username") {
      return "swizzlr"
    }
    addFunction("*") {
      end = Date()
    }
    _ = TitanApp(Request("GET", "/username"))
    XCTAssertNotEqual(start, end)
  }

  func testDifferentMethods() {
    get("/getSomething") {
      return "swizzlrGotSomething!"
    }

    post("/postSomething") {
      return "something posted"
    }

    put("/putSomething") {
      return "i can confirm that stupid stuff is now on the server"
    }

    patch("/patchSomething") {
      return "i guess we don't have a flat tire anymore?"
    }

    delete("/deleteSomething") {
      return "error: could not find the USA or its principles"
    }

    options("/optionSomething") {
      return "I sold movie rights!"
    }

    head("/headSomething") {
      return "OWN GOAL!!"
    }

  }

  func testSamePathDifferentiationByMethod() {
    var username = ""

    get("/username") {
      return username
    }

    post("/username") { (req: RequestType) in
      username = req.body
      return 201
    }

    let resp = TitanApp(Request("POST", "/username", "Lisa"))
    XCTAssertEqual(resp.code, 201)
    XCTAssertEqual(TitanApp(Request("GET", "/username")).body, "Lisa")
  }

  static var allTests: [(String, (TitanAPITests) -> () throws -> Void)] {
    return [
      ("testTitanGet", testTitanGet),
    ]
  }
}
