import XCTest
import TitanCore
import Titan404

class Titan404Tests: XCTestCase {

    static var allTests = [
        ("test404", test404)
        ]

    func test404() {
        let titanInstance = Titan()
        titanInstance.addFunction(defaultTo404)
    }
}
