import XCTest
@testable import TitanTests
@testable import TitanRouterTests
@testable import TitanQueryStringTests
@testable import TitanJSONTests
@testable import TitanHealthzTests
@testable import TitanFormURLEncodedBodyParserTests
@testable import TitanErrorHandlingTests
@testable import TitanCoreTests
@testable import TitanCORSTests
@testable import Titan404Tests

XCTMain([
  testCase(Titan404Tests.allTests),
  testCase(CORSTests.allTests),
  testCase(TitanCoreTests.allTests),
  testCase(TitanErrorHandlingTests.allTests),
  testCase(TitanFormURLEncodedBodyParserTests.allTests),
  testCase(TitanHealthzTests.allTests),
  testCase(TitanJSONTests.allTests),
  testCase(TitanQueryStringTests.allTests),
  testCase(TitanRouterTests.allTests),
  testCase(TitanAPITests.allTests)
])
