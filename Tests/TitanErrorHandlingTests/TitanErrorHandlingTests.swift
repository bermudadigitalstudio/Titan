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
import TitanErrorHandling
import TitanCore
let nullResponse = Response(code: -1, body: Data(), headers: HTTPHeaders())

class TitanErrorHandlingTests: XCTestCase {

    static var allTests = [
        ("testErrorsAreCaught", testErrorsAreCaught)
        ]

    func testErrorsAreCaught() {
        let t = Titan()
        let errorHandler: (Error) -> ResponseType = { (err: Error) in
            let desc = String(describing: err)
            let descData = desc.data(using: .utf8)!
            return Response(code: 500, body: descData, headers: HTTPHeaders())
        }
        t.addFunction(errorHandler: errorHandler) { (_, _) throws -> (RequestType, ResponseType) in
            throw "Oh no"
        }
        XCTAssertEqual(t.app(request: Request(method: .custom(named: "METHOD"), path: "", body: Data(), headers: HTTPHeaders()), response: nullResponse).1.body, "Oh no")
    }
}

extension String: Error {

}
