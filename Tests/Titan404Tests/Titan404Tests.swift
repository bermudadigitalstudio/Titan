import XCTest
import TitanCore
import Titan404

class Titan404Tests: XCTestCase {
    func test404() {
        let titanInstance = Titan()
        titanInstance.addFunction(defaultTo404)
    }
}
