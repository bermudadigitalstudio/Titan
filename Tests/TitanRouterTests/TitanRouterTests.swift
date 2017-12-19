//   Copyright 2017 Enervolution GmbH
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//   https://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
import XCTest
import TitanRouter
import TitanCore

let nullResponse = Response(-1, Data(), HTTPHeaders())

extension Response {
    init(_ string: String) {
        self.body = string.data(using: .utf8) ?? Data()
        self.code = 200
        self.headers = HTTPHeaders()
    }

    init(_ data: Data) {
        self.body = data
        self.code = 200
        self.headers =  HTTPHeaders()
    }
}

final class TitanRouterTests: XCTestCase {

    static var allTests = [
        ("testFunctionalMutableParams", testFunctionalMutableParams),
        ("testBasicGet", testBasicGet),
        ("testTitanEcho", testTitanEcho),
        ("testMultipleRoutes", testMultipleRoutes),
        ("testTitanSugar", testTitanSugar),
        ("testMiddlewareFunction", testMiddlewareFunction),
        ("testDifferentMethods", testDifferentMethods),
        ("testSamePathDifferentiationByMethod", testSamePathDifferentiationByMethod),
        ("testMatchingWildcardComponents", testMatchingWildcardComponents),
        ("testTypesafePathParams", testTypesafePathParams),
        ("testTypesafeMultipleParams", testTypesafeMultipleParams),
        ("testMismatchingLongPaths", testMismatchingLongPaths),
        ("testMatchingWithAQuery", testMatchingWithAQuery)
        ]

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
        let response = app.app(request: Request("GET", "/init", "", HTTPHeaders()), response: nullResponse).1
        XCTAssertEqual(response.code, 500)
        XCTAssertEqual(response.body, "Hello World")
    }

    func testAllMethods() {
        app.allMethods("/user/*") { (req, _) -> (RequestType, ResponseType) in
            // maybe do some tracing code here

            return (req, Response("Heyo"))
        }
        let response = app.app(request: Request("ANYMETHOD", "/user/whatever", "", HTTPHeaders()), response: nullResponse).1
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.body, "Heyo")
    }

    func testBasicGet() {
        app.get("/username") { req, _ in
            return (req, Response("swizzlr"))
        }
        XCTAssertEqual(app.app(request: Request("GET", "/username"), response: nullResponse).1.body, "swizzlr")
    }

    func testTitanEcho() {
        app.get("/echoMyBody") { req, _ in
            return (req, Response(req.body))
        }
        XCTAssertEqual(app.app(request: Request("GET", "/echoMyBody", "hello, this is my body"),
                               response: nullResponse).1.body, "hello, this is my body")
    }

    func testMultipleRoutes() {
        app.get("/username") { req, _ in
            return (req, Response("swizzlr"))
        }

        app.get("/echoMyBody") { (req, _) -> (RequestType, ResponseType) in
            return (req, Response(req.body))
        }
        XCTAssertEqual(String(data: app.app(request: Request("GET", "/echoMyBody", "hello, this is my body"),
                                            response: nullResponse).1.body, encoding: .utf8),
                       "hello, this is my body")
        XCTAssertEqual(app.app(request: Request("GET", "/username"), response: nullResponse).1.body, "swizzlr")
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
        let created = try Response(201, "")
        app.get("/username") { req, _ in
            return (req, Response(username))
        }
        app.post("/username") { (req: RequestType, _) in
            username = req.body!
            return (req, created)
        }

        let resp = app.app(request: Request("POST", "/username", "Lisa"), response: nullResponse).1
        XCTAssertEqual(resp.code, 201)
        XCTAssertEqual(app.app(request: Request("GET", "/username"), response: nullResponse).1.body, "Lisa")
    }

    func testMatchingWildcardComponents() throws {
        app.get("/foo/{foo}/baz/{baz}/bar") { req, _, params in

            XCTAssertNotNil(params["foo"])
            XCTAssertNotNil(params["baz"])

            return (req, Response(200))
        }
        let resp = app.app(request: Request("GET", "/foo/123456/baz/7890/bar"), response: nullResponse).1
        XCTAssertEqual(resp.code, 200)
    }

    func testTypesafePathParams() {
        app.get("/foo/{id}/baz") { req, _, params in
            let id = params["id"] ?? ""
            return (req, Response(id))
        }

        let resp = app.app(request: Request("GET", "/foo/567/baz"), response: nullResponse).1
        XCTAssertEqual(resp.body, "567")
    }

    func testTypesafeMultipleParams() {
        app.get("/foo/{foo}/bar/{bar}") { req, foo, params in
            let foo = params["foo"] ?? ""
            let bar = params["bar"] ?? ""
            return (req, Response("foo=\(foo), bar=\(bar)"))
        }
        let resp2 = app.app(request: Request("GET", "/foo/hello/bar/world"), response: nullResponse).1
        XCTAssertEqual(resp2.body, "foo=hello, bar=world")

        app.get("/foo/{foo}/bar/{bar}/baz/{baz}") { req, _, params in
            let foo = params["foo"] ?? ""
            let bar = params["bar"] ?? ""
            let baz = params["baz"] ?? ""
            return (req, Response("foo=\(foo), bar=\(bar), baz=\(baz)"))
        }
        let resp3 = app.app(request: Request("GET", "/foo/hello/bar/world/baz/my"), response: nullResponse).1
        XCTAssertEqual(resp3.body, "foo=hello, bar=world, baz=my")

        app.get(path: "/foo/{foo}/bar/{bar}/baz/{baz}/qux/{qux}") { req, _, params in
            let foo = params["foo"] ?? ""
            let bar = params["bar"] ?? ""
            let baz = params["baz"] ?? ""
            let qux = params["qux"] ?? ""
            return (req, Response("foo=\(foo), bar=\(bar), baz=\(baz), qux=\(qux)"))
        }
        let resp4 = app.app(request: Request("GET", "/foo/hello/bar/world/baz/my/qux/name"), response: nullResponse).1
        XCTAssertEqual(resp4.body, "foo=hello, bar=world, baz=my, qux=name")

        app.get("/foo/{foo}/bar/{bar}/baz/{baz}/qux/{qux}/yex/{yex}") { req, _, params in
            let foo = params["foo"] ?? ""
            let bar = params["bar"] ?? ""
            let baz = params["baz"] ?? ""
            let qux = params["qux"] ?? ""
            let yex = params["yex"] ?? ""
            return (req, Response("foo=\(foo), bar=\(bar), baz=\(baz), qux=\(qux), yex=\(yex)"))
        }

        let resp5 = app.app(request: Request("GET", "/foo/hello/bar/world/baz/my/qux/name/yex/is"), response: nullResponse).1
        XCTAssertEqual(resp5.body, "foo=hello, bar=world, baz=my, qux=name, yex=is")
    }

    func testMismatchingLongPaths() {
        app.get("/foo/{id}/thing") { req, _, params in
            XCTAssertNotNil(params["id"])
            do {
                return (req, try Response(200, "Got foo"))
            } catch {
                return (req, Response(code: 500, body: Data(), headers: HTTPHeaders()))
            }
        }

        let resp = app.app(request: Request("GET", "/foo/bar"), response: nullResponse).1
        XCTAssertNotEqual(resp.body, "Got foo")
    }

    func testMatchingWithAQuery() {
        app.get("/test/hello") { req, _ in

            return (req, Response(200))
        }
        let resp = app.app(request: Request("GET", "/test/hello?query=thing&q=2"), response: nullResponse).1
        XCTAssertEqual(resp.code, 200)
    }
}
