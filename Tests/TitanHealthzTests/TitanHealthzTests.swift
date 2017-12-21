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
import TitanHealthz
import TitanCore

let nullResponse = Response(code: -1, body: Data(), headers: HTTPHeaders())
final class TitanHealthzTests: XCTestCase {

    static var allTests = [
        ("testBasicHealthCheck", testBasicHealthCheck),
        ("testHealthCheckDoesntMatchOtherRoutes", testHealthCheckDoesntMatchOtherRoutes),
        ("testThrowingHealthCheck", testThrowingHealthCheck),
        ("testNonThrowingHealthCheckWithDiagnostic", testNonThrowingHealthCheckWithDiagnostic)
        ]

    func testBasicHealthCheck() {
        let (_, res) = healthz(Request(method: .get, path: "/healthz", body: Data(), headers: HTTPHeaders()), nullResponse)
        XCTAssertEqual(res.code, 200)
        XCTAssertNotEqual(res.body, "")
    }

    func testHealthCheckDoesntMatchOtherRoutes() {
        let (_, res) = healthz(Request(method: .options, path: "*", body: Data(), headers: HTTPHeaders()), nullResponse)
        XCTAssertNotEqual(res.code, 200)
        XCTAssertEqual(res.body, "")
    }

    func testThrowingHealthCheck() {
        let alwaysUnhealthy = healthzWithCheck { () -> String? in
            throw "Oh no an error"
        }
        let (_, res) = alwaysUnhealthy(Request(method: .get, path: "/healthz", body: Data(), headers: HTTPHeaders()),
                                       nullResponse)
        XCTAssertEqual(res.code, 500)
        XCTAssertTrue(res.body!.contains("Oh no an error"))
    }

    func testNonThrowingHealthCheckWithDiagnostic() {
        let alwaysHealthy = healthzWithCheck { () -> String? in
            return "All is healthy here is some custom info"
        }
        let (_, res) = alwaysHealthy(Request(method: .get, path: "/healthz", body: Data(), headers: HTTPHeaders()),
                                     nullResponse)
        XCTAssertEqual(res.code, 200)
        XCTAssertTrue(res.body!.contains("All is healthy here is some custom info"))
    }
}

extension String: Error {}
