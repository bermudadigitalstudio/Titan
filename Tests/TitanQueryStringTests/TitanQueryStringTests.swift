import XCTest
import TitanQueryString
import TitanCore

final class TitanQueryStringTests: XCTestCase {
    func testQueryPairs() throws {
        let path = "/users?verified=true&q=thomas%20catterall&this_has_space=what+are+thingies"
        let request: RequestType = try Request(method: "GET", path: path, body: "", headers: [])
        let parsedQuery = request.queryPairs
        guard parsedQuery.count == 3 else {
            XCTFail()
            return
        }
        XCTAssertEqual(parsedQuery[0].key, "verified")
        XCTAssertEqual(parsedQuery[0].value, "true")

        XCTAssertEqual(parsedQuery[1].key, "q")
        XCTAssertEqual(parsedQuery[1].value, "thomas catterall")

        XCTAssertEqual(parsedQuery[2].key, "this_has_space")
        XCTAssertEqual(parsedQuery[2].value, "what are thingies")
    }
    func testQuery() throws {
        let path = "/users?verified=true&q=thomas%20catterall&verified=false&this_has_space=what+are+thingies"
        let request: RequestType = try Request(method: "GET", path: path, body: "", headers: [])
        let query = request.query

        XCTAssertEqual(query["q"], "thomas catterall")
        XCTAssertEqual(query["this_has_space"], "what are thingies")
        // Check last value wins
        XCTAssertEqual(query["verified"], "false")
    }
}
