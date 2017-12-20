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
import TitanFormURLEncodedBodyParser
import TitanCore

class TitanFormURLEncodedBodyParserTests: XCTestCase {

    static var allTests = [
        ("testForm", testForm)
        ]

    func testForm() throws {
        let requestBody = """
        foo=bar&baz=&favorite+flavor=flies&resume=when+i+was+young%0D%0Ai+went+to+school&foo=bar2&foo2=bar=&what%20do+you+think=i+dont%20know
        """

        let request = try Request(method: .post, path: "/submit", body: requestBody, headers: HTTPHeaders())
        let parsed = request.formURLEncodedBody
        // Simple
        XCTAssertEqual(parsed[0].name, "foo")
        XCTAssertEqual(parsed[0].value, "bar")
        // Missing value
        XCTAssertEqual(parsed[1].name, "baz")
        XCTAssertEqual(parsed[1].value, "")
        // Spaces
        XCTAssertEqual(parsed[2].name, "favorite flavor")
        XCTAssertEqual(parsed[2].value, "flies")
        // Percent encoded new lines
        XCTAssertEqual(parsed[3].name, "resume")
        XCTAssertEqual(parsed[3].value, "when i was young\r\ni went to school")
        // Simple
        XCTAssertEqual(parsed[4].name, "foo")
        XCTAssertEqual(parsed[4].value, "bar2")

        //  Equal sign in value
        XCTAssertEqual(parsed[5].name, "foo2")
        XCTAssertEqual(parsed[5].value, "bar=")

        // Percent encoded key
        XCTAssertEqual(parsed[6].name, "what do you think")
        XCTAssertEqual(parsed[6].value, "i dont know")

        let dict = request.postParams
        XCTAssertEqual(dict["resume"], "when i was young\r\ni went to school")
        XCTAssertEqual(dict["foo"], "bar2") // check repeats, last value wins
    }
}
