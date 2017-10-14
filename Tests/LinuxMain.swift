import XCTest
@testable import TitanTests
@testable import TitanCORSTests
@testable import TitanErrorHandlingTests
@testable import TitanFormURLEncodedBodyParserTests
@testable import TitanJSONTests
@testable import TitanQueryStringTests
@testable import TitanRouterTests

XCTMain([
    testCase(TitanAPITests.allTests),
    testCase(CORSTests.allTests),
    testCase(TitanErrorHandlingTests.allTests),
    testCase(TitanFormURLEncodedBodyParserTests.allTests),
    testCase(TitanJSONTests.allTests),
    testCase(TitanQueryStringTests.allTests),
    testCase(TitanRouterTests.allTests)
])
