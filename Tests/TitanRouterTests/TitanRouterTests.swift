import XCTest
import TitanRouter
import TitanCore
let nullResponse = Response(-1, Data(), [])

extension Response {
    init(_ string: String) {
        self.body = string.data(using: .utf8) ?? Data()
        self.code = 200
        self.headers = []
    }

    init(_ data: Data) {
        self.body = data
        self.code = 200
        self.headers = []
    }
}

final class TitanRouterTests: XCTestCase {
    var app: Titan!
    override func setUp() {
        app = Titan()
    }

    func testFunctionalMutableParams() {
        let app = Titan()
        app.get("/init") { (req, res) -> (RequestType, ResponseType) in
            var newReq = req.copy()
            var newRes = res.copy()
            newRes.body = "Hello World".data(using: .utf8) ?? Data()
            newReq.path = "/rewritten"
            newRes.code = 500
            return (newReq, newRes)
        }
        app.addFunction { (req, res) -> (RequestType, ResponseType) in
            XCTAssertEqual(req.path, "/rewritten")
            return (req, res)
        }
        let response = app.app(request: Request("GET", "/init", "", []), response: nullResponse).1
        XCTAssertEqual(response.code, 500)
        XCTAssertEqual(response.bodyString, "Hello World")
    }

    func testBasicGet() {
        app.get("/username") { req, _ in
            return (req, Response("swizzlr"))
        }
        XCTAssertEqual(app.app(request: Request("GET", "/username"), response: nullResponse).1.bodyString, "swizzlr")
    }

    func testTitanEcho() {
        app.get("/echoMyBody") { req, _ in
            return (req, Response(req.body))
        }
        XCTAssertEqual(app.app(request: Request("GET", "/echoMyBody", "hello, this is my body"), response: nullResponse).1.bodyString, "hello, this is my body")
    }

    func testMultipleRoutes() {
        app.get("/username") { req, _ in
            return (req, Response("swizzlr"))
        }

        app.get("/echoMyBody") { (req, _) -> (RequestType, ResponseType) in
            return (req, Response(req.body))
        }
        XCTAssertEqual(String(data: app.app(request: Request("GET", "/echoMyBody", "hello, this is my body"), response: nullResponse).1.body, encoding: .utf8),
                       "hello, this is my body")
        XCTAssertEqual(app.app(request: Request("GET", "/username"), response: nullResponse).1.bodyString, "swizzlr")
    }

    func testTitanSugar() {
        let somePremadeFunction: Function = { req, res in
            return (req, res)
        }
        app.get(path: "/username", handler: somePremadeFunction)
        app.get("/username", somePremadeFunction)
    }

    func testMiddlewareFunction() {
        var start = Date()
        var end = start
        app.addFunction("*") { (req: RequestType, res: ResponseType) -> (RequestType, ResponseType) in
            start = Date()
            return (req, res)
        }
        app.get("/username") { req, _ in
            return (req, Response("swizzlr"))
        }
        app.addFunction("*") { (req: RequestType, res: ResponseType) -> (RequestType, ResponseType) in
            end = Date()
            return (req, res)
        }
        _ = app.app(request: Request("GET", "/username"), response: nullResponse).1
        XCTAssertLessThan(start, end)
    }

    func testDifferentMethods() {
        app.get("/getSomething") { req, _ in
            return (req, Response("swizzlrGotSomething!"))
        }

        app.post("/postSomething") { req, _ in
            return (req, Response("something posted"))
        }

        app.put("/putSomething") { req, _ in
            return (req, Response( "i can confirm that stupid stuff is now on the server"))
        }

        app.patch("/patchSomething") { req, _ in
            return (req, Response("i guess we don't have a flat tire anymore?"))
        }

        app.delete("/deleteSomething") { req, _ in
            return (req, Response("error: could not find the USA or its principles"))
        }

        app.options("/optionSomething") { req, _ in
            return (req, Response("I sold movie rights!"))
        }

        app.head("/headSomething") { req, _ in
            return (req, Response("OWN GOAL!!"))
        }

    }

    func testSamePathDifferentiationByMethod() throws {
        var username = ""
        let created = Response(201, "")
        app.get("/username") { req, _ in
            return (req, Response(username))
        }
        app.post("/username") { (req: RequestType, _) in
            username = req.bodyString!
            return (req, created)
        }

        let resp = app.app(request: Request("POST", "/username", "Lisa"), response: nullResponse).1
        XCTAssertEqual(resp.code, 201)
        XCTAssertEqual(app.app(request: Request("GET", "/username"), response: nullResponse).1.bodyString, "Lisa")
    }

    func testMatchingWildcardComponents() throws {
        app.get("/foo/*/baz/*/bar") { req, _ in
            return (req, Response(200))
        }
        let resp = app.app(request: Request("GET", "/foo/123456/baz/7890/bar"), response: nullResponse).1
        XCTAssertEqual(resp.code, 200)
    }

    func testTypesafePathParams() {
        app.get("/foo/*/baz") { req, id, _ in
            return (req, Response(id))
        }

        let resp = app.app(request: Request("GET", "/foo/567/baz"), response: nullResponse).1
        XCTAssertEqual(resp.bodyString, "567")
    }

    func testTypesafeMultipleParams() {
        app.get("/foo/*/bar/*/baz/*/qux/*/yex/*") { req, foo, bar, baz, qux, yex, _ in
            return (req, Response("foo=\(foo), bar=\(bar), baz=\(baz), qux=\(qux), yex=\(yex)"))
        }

        let resp = app.app(request: Request("GET", "/foo/hello/bar/world/baz/my/qux/name/yex/is"), response: nullResponse).1
        XCTAssertEqual(resp.bodyString, "foo=hello, bar=world, baz=my, qux=name, yex=is")
    }

    func testMismatchingLongPaths() {
        app.get("/foo/*/thing") { req, _ in
            return (req, Response(200, "Got foo"))
        }

        let resp = app.app(request: Request("GET", "/foo/bar"), response: nullResponse).1
        XCTAssertNotEqual(resp.bodyString, "Got foo")
    }

    func testMatchingWithAQuery() {
        app.get("/test/hello") { req, _ in

            return (req, Response(200))
        }
        let resp = app.app(request: Request("GET", "/test/hello?query=thing&q=2"), response: nullResponse).1
        XCTAssertEqual(resp.code, 200)
    }
}
