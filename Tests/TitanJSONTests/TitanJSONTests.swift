import XCTest
import TitanJSON
import TitanCore

class TitanJSONTests: XCTestCase {

    func testJSONTRequest() throws {
        let jsonBody = "{\"data\": [1, 2, 3]}"
        let req: RequestType = try Request(method: "POST", path: "/ingest", body: jsonBody, headers: [])
        guard let json = req.json as? Dictionary<String, Array<Int>> else {
            XCTFail("Received: \(String(describing: req.json))")
            return
        }
        XCTAssertEqual(json["data"]!, [1, 2, 3])
    }

    func testJSONResponse() {
        let response = Response(code: 200, json: ["hello": "world"])
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.headers.first?.value, "application/json")
        XCTAssertEqual(response.bodyString, "{\"hello\":\"world\"}")
    }

    func testJSONCodableResponse() {
        let response = Response(code: 200, object: Greeting(hello: "world"))
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.headers.first?.value, "application/json")
        XCTAssertEqual(response.bodyString, "{\"hello\":\"world\"}")
    }

    struct Greeting: Codable {
        let hello: String
    }
}
