import XCTest
import TitanQueryString
import TitanCore

final class TitanQueryStringTests: XCTestCase {

    static var allTests = [
        ("testQueryPairs", testQueryPairs),
        ("testQuery", testQuery)
        ]

    func testQueryPairs() throws {
        let path = "/users?verified=true&q=thomas%20catterall&this_has_space=what+are+thingies&this_has_plus=2%2B2%3D4"
        let request: RequestType = try Request(method: "GET", path: path, body: "", headers: HTTPHeaders())
        let parsedQuery = request.queryPairs
        guard parsedQuery.count == 4 else {
            XCTFail()
            return
        }
        XCTAssertEqual(parsedQuery[0].key, "verified")
        XCTAssertEqual(parsedQuery[0].value, "true")

        XCTAssertEqual(parsedQuery[1].key, "q")
        XCTAssertEqual(parsedQuery[1].value, "thomas catterall")

        XCTAssertEqual(parsedQuery[2].key, "this_has_space")
        XCTAssertEqual(parsedQuery[2].value, "what are thingies")

        XCTAssertEqual(parsedQuery[3].key, "this_has_plus")
        XCTAssertEqual(parsedQuery[3].value, "2+2=4")
    }
    func testQuery() throws {
        let path = "/users?verified=true&q=thomas%20catterall&verified=false&this_has_space=what+are+thingies"
        let request: RequestType = try Request(method: "GET", path: path, body: "", headers: HTTPHeaders())
        let query = request.query

        XCTAssertEqual(query["q"], "thomas catterall")
        XCTAssertEqual(query["this_has_space"], "what are thingies")
        // Check last value wins
        XCTAssertEqual(query["verified"], "false")
    }
}
