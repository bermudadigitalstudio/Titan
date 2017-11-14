import XCTest
import TitanHealthz
import TitanCore

final class TitanHealthzTests: XCTestCase {
    func testBasicHealthCheck() {
        let (_, res) = healthz(Request(method: "GET", path: "/healthz", body: Data(), headers: []), Response(code: -1, body: Data(), headers: []))
        XCTAssertEqual(res.code, 200)
        XCTAssertNotEqual(res.bodyString, "")
    }

    func testThrowingHealthCheck() {
        let alwaysUnhealthy = healthzWithCheck { () -> String? in
            throw "Oh no an error"
        }
        let (_, res) = alwaysUnhealthy(Request(method: "GET", path: "/healthz", body: Data(), headers: []),
                                       Response(code: -1, body: Data(), headers: []))
        XCTAssertEqual(res.code, 500)
        XCTAssertTrue(res.bodyString!.contains("Oh no an error"))
    }

    func testNonThrowingHealthCheckWithDiagnostic() {
        let alwaysHealthy = healthzWithCheck { () -> String? in
            return "All is healthy here is some custom info"
        }
        let (_, res) = alwaysHealthy(Request(method: "GET", path: "/healthz", body: Data(), headers: []),
                                     Response(code: -1, body: Data(), headers: []))
        XCTAssertEqual(res.code, 200)
        XCTAssertTrue(res.bodyString!.contains("All is healthy here is some custom info"))
    }
}

extension String: Error {}
