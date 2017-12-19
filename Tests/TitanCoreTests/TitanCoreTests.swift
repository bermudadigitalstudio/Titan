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
@testable import TitanCore

let nullResponse = Response(code: -1, body: Data(), headers: HTTPHeaders())

final class TitanCoreTests: XCTestCase {

    static var allTests = [
        ("testCanAddFunction", testCanAddFunction),
        ("testFunctionsAreInvokedInOrder", testFunctionsAreInvokedInOrder),
        ("testFirstFunctionRegisteredReceivesRequest", testFirstFunctionRegisteredReceivesRequest),
        ("testResponseComesFromLastResponseReturned", testResponseComesFromLastResponseReturned),
        ("testFunctionInputIsOutputOfPrecedingFunction", testFunctionInputIsOutputOfPrecedingFunction),
        ("testErrorDescriptions", testErrorDescriptions),
        ("testHeaderSubscript", testHeaderSubscript),
        ("testHeaders", testHeaders)
    ]

    func testCanAddFunction() {
        Titan().addFunction({ (req: RequestType, res: ResponseType) -> (RequestType, ResponseType) in
            print(req)
            print(res)
            var newReq = req.copy()
            newReq.headers["hello"] = "world"

            do {
                return (newReq, try Response(code: -1, body: "", headers: HTTPHeaders()))
            } catch {
            }

            return (newReq, Response(code: 500, body: Data(), headers: HTTPHeaders()) )
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

        _ = t.app(request: Request(method: "", path: "", body: Data(), headers: HTTPHeaders()), response: nullResponse)
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

        _ = t.app(request: Request(method: "METHOD", path: "/PATH", body: "body".data(using: .utf8)!,
                                   headers: HTTPHeaders(dictionaryLiteral: ("some-header", "some-value"))), response: nullResponse)
        XCTAssertEqual(request.body, "body")
        XCTAssertEqual(request.method, "METHOD")
        XCTAssertEqual(request.path, "/PATH")
        XCTAssertEqual(request.headers["some-header"], "some-value")
    }

    func testResponseComesFromLastResponseReturned() throws {
        let t = Titan()
        t.addFunction { req, _ in

            do {
                return (req, try Response(code: 100,
                                          body: "not this body",
                                          headers: HTTPHeaders(dictionaryLiteral: ("content-type-WRONG", "application/json"))))
            } catch {
            }
            return (req, Response(code: 500, body: Data(), headers: HTTPHeaders()))
        }

        t.addFunction { req, _ in
            do {
                return (req, try Response(code: 700,
                                          body: "response body",
                                          headers: HTTPHeaders(dictionaryLiteral: ("content-type", "text/plain"))))

            } catch {
            }
            return (req, Response(code: 500, body: Data(), headers: HTTPHeaders()))
        }

        let response = t.app(request: Request(method: "", path: "", body: Data(), headers: HTTPHeaders()), response: nullResponse).1
        XCTAssertEqual(response.body, "response body")
        XCTAssertEqual(response.code, 700)
        XCTAssertEqual(response.headers["content-type"], "text/plain")
    }

    func testFunctionInputIsOutputOfPrecedingFunction() throws {
        let t = Titan()
        t.addFunction { _, _  in
            do {
                return (Request(method: "METHOD",
                                path: "/PATH",
                                body: "body".data(using: .utf8)!,
                                headers: HTTPHeaders(dictionaryLiteral: ("some-header", "some-value"))),
                        try Response(code: 700,
                                     body: "response body",
                                     headers: HTTPHeaders(dictionaryLiteral: ("content-type", "text/plain"))))
            } catch {
            }
            return (Request(method: "METHOD",
                            path: "/PATH",
                            body: "response body".data(using: .utf8)!,
                            headers: HTTPHeaders(dictionaryLiteral: ("some-header", "some-value"))),
                    Response(code: 500, body: Data(), headers: HTTPHeaders()))
        }
        var request: RequestType!, response: ResponseType!

        t.addFunction { req, res in
            request = req
            response = res
            return (req, res)
        }

        _ = t.app(request: Request(method: "", path: "", body: Data(), headers: HTTPHeaders()), response: nullResponse)

        XCTAssertEqual(request.body, "body")
        XCTAssertEqual(request.method, "METHOD")
        XCTAssertEqual(request.path, "/PATH")
        XCTAssertEqual(request.headers["some-header"], "some-value")

        XCTAssertEqual(response.body, "response body".data(using: .utf8))
        XCTAssertEqual(response.code, 700)
        XCTAssertEqual(response.headers["content-type"], "text/plain")
    }

    func testErrorDescriptions() {
        let errors = [TitanError.dataConversion]
        for e in errors {
            switch e {
            case .dataConversion:
                XCTAssertNotNil(e.errorDescription)
                XCTAssertNotNil(e.recoverySuggestion)
                XCTAssertNotNil(e.failureReason)
            }
        }
    }

    func testHeaderSubscript() {
        let r = Request(method: "METHOD",
                        path: "/PATH",
                        body: "response body".data(using: .utf8)!,
                        headers: HTTPHeaders(dictionaryLiteral: ("some-header", "some-value"), ("some-OTHER-header", "some-OTHER-value")))
        XCTAssertEqual(r.headers["some-other-header"], "some-OTHER-value")
        XCTAssertEqual(r.headers["some-header"], "some-value")
        XCTAssertEqual(r.headers["SOME-HEADER"], "some-value")
    }

    func testHeaders() {
        var headers = HTTPHeaders()

        headers["Hello"] = nil
        XCTAssertNil(headers["Hello"])

        headers["Accept"] = "text"
        XCTAssertEqual(headers["Accept"], "text")
        headers["Link"] = "http://example.com"
        XCTAssertEqual(headers["link"], "http://example.com")
        XCTAssertNotNil(headers["link"])
        headers.removeHeaders(name: "link")
        XCTAssertNil(headers["link"])
        XCTAssertNotNil(headers["Accept"])

        let anotherHeaders = HTTPHeaders(dictionaryLiteral: ("Content-Length", "10"))
        XCTAssertEqual(anotherHeaders["Content-Length"], "10")

        XCTAssertEqual(headers.count, 1)
        // swiftlint:disable shorthand_operator
        headers = headers + anotherHeaders
        // swiftlint:enable shorthand_operator
        XCTAssertEqual(headers["Content-Length"], "10")
        XCTAssertEqual(headers.count, 2)

        let heads = [("Content-Length", "10"), ("Accept", "text")]
        let copyHeaders = HTTPHeaders(headers: heads)
        XCTAssertEqual(copyHeaders.count, 2)
        XCTAssertEqual(copyHeaders["Content-Length"], "10")
        XCTAssertEqual(copyHeaders["Accept"], "text")
    }

}
