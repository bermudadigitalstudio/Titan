import XCTest
@testable import TitanCore

final class FunctionTests: XCTestCase {

    func testCanAddFunction() {
        Titan().addFunction({ (req: RequestType, res: ResponseType) -> (RequestType, ResponseType) in
            print(req)
            print(res)
            var newReq = req.copy()
            newReq.headers.append(("hello", "world"))

            do {
                return (newReq, try Response(code: -1, body: "", headers: []))
            } catch {
            }

            return (newReq, Response(code: 500, body: Data(), headers: []) )
        })
    }

    func testFunctionsAreInvokedInOrder() {
        let t = Titan()
        var accumulator: [Int] = []

        t.addFunction { (request, response) -> (RequestType, ResponseType) in
            accumulator.append(0)
            return (request, response)
        }

        t.addFunction { (request, response) -> (RequestType, ResponseType) in
            accumulator.append(1)
            return (request, response)
        }

        t.addFunction { (request, response) -> (RequestType, ResponseType) in
            accumulator.append(2)
            return (request, response)
        }

        t.addFunction { (request, response) -> (RequestType, ResponseType) in
            accumulator.append(3)
            return (request, response)
        }

        _ = t.app(request: Request(method: "", path: "", body: Data(), headers: []))
        XCTAssertEqual(accumulator.count, 4)
        XCTAssertEqual(accumulator[3], 3)
    }

    func testFirstFunctionRegisteredReceivesRequest() {
        let t = Titan()
        var request: RequestType!
        t.addFunction { req, res in
            request = req
            return (req, res)
        }

        _ = t.app(request: Request(method: "METHOD",
                                   path: "/PATH",
                                   body: "body".data(using: .utf8)!,
                                   headers: [("some-header", "some-value")]))
        XCTAssertEqual(request.bodyString, "body")
        XCTAssertEqual(request.method, "METHOD")
        XCTAssertEqual(request.path, "/PATH")
        XCTAssertEqual(request.headers.first!.name, "some-header")
        XCTAssertEqual(request.headers.first!.value, "some-value")
    }

    func testResponseComesFromLastResponseReturned() throws {
        let t = Titan()
        t.addFunction { req, _ in

            do {
                return (req, try Response(code: 100,
                                          body: "not this body",
                                          headers: [("content-type-WRONG", "application/json")]))
            } catch {
            }
            return (req, Response(code: 500, body: Data(), headers: []))
        }

        t.addFunction { req, _ in
            do {
                return (req, try Response(code: 700,
                                          body: "response body",
                                          headers: [("content-type", "text/plain")]))

            } catch {
            }
            return (req, Response(code: 500, body: Data(), headers: []))
        }

        let response = t.app(request: Request(method: "", path: "", body: Data(), headers: []))
        XCTAssertEqual(response.bodyString, "response body")
        XCTAssertEqual(response.code, 700)
        XCTAssertEqual(response.headers.first!.name, "content-type")
        XCTAssertEqual(response.headers.first!.value, "text/plain")
    }

    func testFunctionInputIsOutputOfPrecedingFunction() throws {
        let t = Titan()
        t.addFunction { _, _  in
            do {
                return (Request(method: "METHOD",
                                path: "/PATH",
                                body: "body".data(using: .utf8)!,
                                headers: [("some-header", "some-value")]),
                        try Response(code: 700,
                                     body: "response body",
                                     headers: [("content-type", "text/plain")]))
            } catch {
            }
            return (Request(method: "METHOD",
                            path: "/PATH",
                            body: "response body".data(using: .utf8)!,
                            headers: [("some-header", "some-value")]), Response(code: 500, body: Data(), headers: []))
        }
        var request: RequestType!, response: ResponseType!
        t.addFunction { req, res in
            request = req
            response = res
            return (req, res)
        }

        _ = t.app(request: Request(method: "", path: "", body: Data(), headers: []))

        XCTAssertEqual(request.bodyString, "body")
        XCTAssertEqual(request.method, "METHOD")
        XCTAssertEqual(request.path, "/PATH")
        XCTAssertEqual(request.headers.first!.name, "some-header")
        XCTAssertEqual(request.headers.first!.value, "some-value")

        XCTAssertEqual(response.body, "response body".data(using: .utf8))
        XCTAssertEqual(response.code, 700)
        XCTAssertEqual(response.headers.first!.name, "content-type")
        XCTAssertEqual(response.headers.first!.value, "text/plain")
    }

    static var allTests: [(String, (FunctionTests) -> () throws -> Void)] {
        return [
            ("testCanAddFunction", testCanAddFunction),
            ("testFunctionsAreInvokedInOrder", testFunctionsAreInvokedInOrder),
            ("testFunctionInputIsOutputOfPrecedingFunction", testFunctionInputIsOutputOfPrecedingFunction),
            ("testResponseComesFromLastResponseReturned", testResponseComesFromLastResponseReturned),
            ("testFirstFunctionRegisteredReceivesRequest", testFirstFunctionRegisteredReceivesRequest)
        ]
    }
}
