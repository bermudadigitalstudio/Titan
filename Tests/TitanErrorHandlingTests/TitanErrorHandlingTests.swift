import XCTest
import TitanErrorHandling
import TitanCore
let nullResponse = Response(code: -1, body: Data(), headers: [])

class TitanErrorHandlingTests: XCTestCase {
    func testErrorsAreCaught() {
        let t = Titan()
        let errorHandler: (Error) -> ResponseType = { (err: Error) in
            let desc = String(describing: err)
            let descData = desc.data(using: .utf8)!
            return Response(code: 500, body: descData, headers: [])
        }
        t.addFunction(errorHandler: errorHandler) { (_, _) throws -> (RequestType, ResponseType) in
            throw "Oh no"
        }
        XCTAssertEqual(t.app(request: Request(method: "", path: "", body: Data(), headers: []), response: nullResponse).1.bodyString, "Oh no")
    }
}

extension String: Error {

}
