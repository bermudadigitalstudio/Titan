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
        let req: RequestType = try Request(method: .post, path: "/ingest", body: jsonBody, headers: HTTPHeaders())
        guard let json = req.json as? Dictionary<String, Array<Int>> else {
            XCTFail("Received: \(String(describing: req.json))")
            return
        }
        XCTAssertEqual(json["data"]!, [1, 2, 3])
    }

    func testJSONResponse() throws {
        let response = try Response(code: 200, json: ["hello": "world"])
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.headers["content-type"], "application/json")
        XCTAssertEqual(response.body, "{\"hello\":\"world\"}")
    }

    func testJSONCodableResponse() throws {
        let response = try Response(code: 200, object: Greeting(hello: "world"))
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.headers["content-type"], "application/json")
        XCTAssertEqual(response.body, "{\"hello\":\"world\"}")
    }

    struct Greeting: Codable {
        let hello: String
    }
}
