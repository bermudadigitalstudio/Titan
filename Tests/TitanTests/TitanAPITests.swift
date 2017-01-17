import XCTest
import Titan

final class TitanAPITests: XCTestCase {
  var titanInstance: Titan!
  override func setUp() {
    titanInstance = Titan()
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

  func testFunctionalMutableParams() {
    let app = Titan()
    app.get("/init") { (req: inout Request, res: inout Response) -> (RequestType, ResponseType) in
      var newReq = req
      var newRes = res
      newRes.body = "Hello World"
      newReq.path = "/rewritten"
      newRes.code = 500
      // Check that mutating the inout params has no effect on the function chain – ONLY the returned values should matter
      res.code = 400
      res.body = "Should not ever come into the response"
      return (newReq, newRes)
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
    titanInstance.get("/username") {
      return "swizzlr"
    }
    XCTAssertEqual(titanInstance.app(request: Request("GET", "/username")).body, "swizzlr")
  }

  func testTitanEcho() {
    titanInstance.get("/echoMyBody") { req in
      return req.body
    }
    XCTAssertEqual(titanInstance.app(request: Request("GET", "/echoMyBody", "hello, this is my body")).body,
                   "hello, this is my body")
  }

  func testMultipleRoutes() {
    titanInstance.get("/username") {
      return "swizzlr"
    }

    titanInstance.get("/echoMyBody") { req in
      return req.body
    }
    XCTAssertEqual(titanInstance.app(request: Request("GET", "/echoMyBody", "hello, this is my body")).body,
                   "hello, this is my body")
    XCTAssertEqual(titanInstance.app(request: Request("GET", "/username")).body, "swizzlr")
  }

  func testTitanSugar() {
    let somePremadeFunction: Function = { req, res in
      return (req, res)
    }
    titanInstance.get(path: "/username", handler: somePremadeFunction)
    titanInstance.get("/username", somePremadeFunction)
  }

  func testFunctionFunction() {
    var start = Date()
    var end = start
    titanInstance.addFunction("*") {
      start = Date()
    }
    titanInstance.get("/username") {
      return "swizzlr"
    }
    titanInstance.addFunction("*") {
      end = Date()
    }
    _ = titanInstance.app(request: Request("GET", "/username"))
    XCTAssertNotEqual(start, end)
  }

  func testDifferentMethods() {
    titanInstance.get("/getSomething") {
      return "swizzlrGotSomething!"
    }

    titanInstance.post("/postSomething") {
      return "something posted"
    }

    titanInstance.put("/putSomething") {
      return "i can confirm that stupid stuff is now on the server"
    }

    titanInstance.patch("/patchSomething") {
      return "i guess we don't have a flat tire anymore?"
    }

    titanInstance.delete("/deleteSomething") {
      return "error: could not find the USA or its principles"
    }

    titanInstance.options("/optionSomething") {
      return "I sold movie rights!"
    }

    titanInstance.head("/headSomething") {
      return "OWN GOAL!!"
    }

  }

  func testSamePathDifferentiationByMethod() {
    var username = ""

    titanInstance.get("/username") {
      return username
    }

    titanInstance.post("/username") { (req: RequestType) -> Int in
      username = req.body
      return 201
    }

    let resp = titanInstance.app(request: Request("POST", "/username", "Lisa"))
    XCTAssertEqual(resp.code, 201)
    XCTAssertEqual(titanInstance.app(request: Request("GET", "/username")).body, "Lisa")
  }

  static var allTests: [(String, (TitanAPITests) -> () throws -> Void)] {
    return [
      ("testTitanGet", testTitanGet),
    ]
  }
}
