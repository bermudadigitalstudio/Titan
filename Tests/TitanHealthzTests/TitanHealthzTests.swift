import XCTest
import TitanHealthz
import TitanCore

let nullResponse = Response(code: -1, body: Data(), headers: [])
final class TitanHealthzTests: XCTestCase {
    func testBasicHealthCheck() {
        let (_, res) = healthz(Request(method: "GET", path: "/healthz", body: Data(), headers: []), nullResponse)
        XCTAssertEqual(res.code, 200)
        XCTAssertNotEqual(res.body, "")
    }
    
    func testHealthCheckDoesntMatchOtherRoutes() {
        let (_, res) = healthz(Request(method: "options", path: "*", body: Data(), headers: []), nullResponse)
        XCTAssertNotEqual(res.code, 200)
        XCTAssertEqual(res.body, "")
    }

    func testThrowingHealthCheck() {
        let alwaysUnhealthy = healthzWithCheck { () -> String? in
            throw "Oh no an error"
        }
        let (_, res) = alwaysUnhealthy(Request(method: "GET", path: "/healthz", body: Data(), headers: []),
                                       nullResponse)
        XCTAssertEqual(res.code, 500)
        XCTAssertTrue(res.body!.contains("Oh no an error"))
    }

    func testNonThrowingHealthCheckWithDiagnostic() {
        let alwaysHealthy = healthzWithCheck { () -> String? in
            return "All is healthy here is some custom info"
        }
        let (_, res) = alwaysHealthy(Request(method: "GET", path: "/healthz", body: Data(), headers: []),
                                     nullResponse)
        XCTAssertEqual(res.code, 200)
        XCTAssertTrue(res.body!.contains("All is healthy here is some custom info"))
    }
}

extension String: Error {}
