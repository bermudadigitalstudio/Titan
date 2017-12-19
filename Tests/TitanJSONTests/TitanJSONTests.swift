import XCTest
import TitanJSON
import TitanCore

class TitanJSONTests: XCTestCase {

    static var allTests = [
        ("testJSONTRequest", testJSONTRequest),
        ("testJSONResponse", testJSONResponse),
        ("testJSONCodableResponse", testJSONCodableResponse)
        ]

    func testJSONTRequest() throws {
        let jsonBody = "{\"data\": [1, 2, 3]}"
        let req: RequestType = try Request(method: "POST", path: "/ingest", body: jsonBody, headers: HTTPHeaders())
        guard let json = req.json as? Dictionary<String, Array<Int>> else {
            XCTFail("Received: \(String(describing: req.json))")
            return
        }
        XCTAssertEqual(json["data"]!, [1, 2, 3])
    }

    func testJSONResponse() throws {
        let response = try Response(code: 200, json: ["hello": "world"])
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.headers.headers.first?.value, "application/json")
        XCTAssertEqual(response.body, "{\"hello\":\"world\"}")
    }

    func testJSONCodableResponse() throws {
        let response = try Response(code: 200, object: Greeting(hello: "world"))
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.headers.headers.first?.value, "application/json")
        XCTAssertEqual(response.body, "{\"hello\":\"world\"}")
    }

    struct Greeting: Codable {
        let hello: String
    }
}
