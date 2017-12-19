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
import TitanCore
import Titan404

let nullResponse = Response(code: -1, body: Data(), headers: HTTPHeaders())

class Titan404Tests: XCTestCase {

    static var allTests = [
        ("test404", test404)
        ]

    func test404() {
        let titanInstance = Titan()
        titanInstance.addFunction(defaultTo404)

        let response = titanInstance.app(request: Request(method: "GET", path: "/notfound", body: Data(), headers: HTTPHeaders()),
                                         response: nullResponse)

        XCTAssertEqual(response.1.code, 404)
    }
}
