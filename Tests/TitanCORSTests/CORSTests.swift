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
import TitanCORS
import TitanCore
import XCTest
let nullResponse = Response(code: -1, body: Data(), headers: HTTPHeaders())

final class CORSTests: XCTestCase {

    static var allTests = [
        ("testCanAddCorsFunctionToTitan", testCanAddCorsFunctionToTitan),
        ("testTitanCanRespondToPreflight", testTitanCanRespondToPreflight),
        ("testTitanCanAllowAllOrigins", testTitanCanAllowAllOrigins)
        ]

    var titanInstance: Titan!
    override func setUp() {
        titanInstance = Titan()
    }
    override func tearDown() {
        titanInstance = nil
    }
    func testCanAddCorsFunctionToTitan() {
        titanInstance.addFunction(respondToPreflightAllowingAllMethods)
        titanInstance.addFunction(allowAllOrigins)
        TitanCORS.addInsecureCORSSupport(titanInstance)
    }

    func testTitanCanRespondToPreflight() throws {
        titanInstance.addFunction(respondToPreflightAllowingAllMethods)

        let headers: [Header] = [("Access-Control-Request-Method", "POST"), ("Access-Control-Request-Headers", "X-Custom-Header")]
        let res = titanInstance.app(request: try Request(method: .options,
                                                         path: "/onuhoenth",
                                                         body: "",
                                                         headers: HTTPHeaders(headers: headers)),
                                    response: nullResponse).1
        XCTAssertEqual(res.code, 200)
        XCTAssertEqual(res.body, "")

        XCTAssertEqual(res.headers["access-control-allow-methods"]?.lowercased(), "post")
        XCTAssertEqual(res.headers["access-control-allow-headers"]?.lowercased(), "x-custom-header")
    }

    func testTitanCanAllowAllOrigins() throws {
        titanInstance.addFunction(allowAllOrigins)
        let res = titanInstance.app(request: try Request(method: .custom(named: "ANYMETHOD"),
                                                         path: "NOT EVEN A REAL PATH",
                                                         body: "WOWOIE", headers: HTTPHeaders()), response: nullResponse).1
        XCTAssertEqual(res.headers["access-control-allow-origin"], "*")
    }
}
