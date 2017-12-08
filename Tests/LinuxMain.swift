// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

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
extension CORSTests {
  static var allTests = [
    ("testCanAddCorsFunctionToTitan", testCanAddCorsFunctionToTitan),
    ("testTitanCanRespondToPreflight", testTitanCanRespondToPreflight),
    ("testTitanCanAllowAllOrigins", testTitanCanAllowAllOrigins),
  ]
}
extension FunctionTests {
  static var allTests = [
    ("testCanAddFunction", testCanAddFunction),
    ("testFunctionsAreInvokedInOrder", testFunctionsAreInvokedInOrder),
    ("testFirstFunctionRegisteredReceivesRequest", testFirstFunctionRegisteredReceivesRequest),
    ("testResponseComesFromLastResponseReturned", testResponseComesFromLastResponseReturned),
    ("testFunctionInputIsOutputOfPrecedingFunction", testFunctionInputIsOutputOfPrecedingFunction),
    ("testErrorDescriptions", testErrorDescriptions),
  ]
}
extension Titan404Tests {
  static var allTests = [
    ("test404", test404),
  ]
}
extension TitanAPITests {
  static var allTests = [
    ("testFunctionalMutableParams", testFunctionalMutableParams),
    ("testTitanGet", testTitanGet),
    ("testTitanEcho", testTitanEcho),
    ("testMultipleRoutes", testMultipleRoutes),
    ("testTitanSugar", testTitanSugar),
    ("testFunctionFunction", testFunctionFunction),
    ("testDifferentMethods", testDifferentMethods),
    ("testErrorsAreCaught", testErrorsAreCaught),
    ("testSamePathDifferentiationByMethod", testSamePathDifferentiationByMethod),
    ("testCanAccessJSONBody", testCanAccessJSONBody),
    ("testCanAccessFormURLEncodedBody", testCanAccessFormURLEncodedBody),
    ("testCanAccessQueryString", testCanAccessQueryString),
    ("testTypesafePathParams", testTypesafePathParams),
    ("test404", test404),
    ("testPredicates", testPredicates),
    ("testAuthentication", testAuthentication),
  ]
}
extension TitanErrorHandlingTests {
  static var allTests = [
    ("testErrorsAreCaught", testErrorsAreCaught),
  ]
}
extension TitanFormURLEncodedBodyParserTests {
  static var allTests = [
    ("testExample", testExample),
  ]
}
extension TitanHealthzTests {
  static var allTests = [
    ("testBasicHealthCheck", testBasicHealthCheck),
    ("testHealthCheckDoesntMatchOtherRoutes", testHealthCheckDoesntMatchOtherRoutes),
    ("testThrowingHealthCheck", testThrowingHealthCheck),
    ("testNonThrowingHealthCheckWithDiagnostic", testNonThrowingHealthCheckWithDiagnostic),
  ]
}
extension TitanJSONTests {
  static var allTests = [
    ("testJSONTRequest", testJSONTRequest),
    ("testJSONResponse", testJSONResponse),
    ("testJSONCodableResponse", testJSONCodableResponse),
  ]
}
extension TitanQueryStringTests {
  static var allTests = [
    ("testQueryPairs", testQueryPairs),
    ("testQuery", testQuery),
  ]
}
extension TitanRouterTests {
  static var allTests = [
    ("testFunctionalMutableParams", testFunctionalMutableParams),
    ("testBasicGet", testBasicGet),
    ("testTitanEcho", testTitanEcho),
    ("testMultipleRoutes", testMultipleRoutes),
    ("testTitanSugar", testTitanSugar),
    ("testMiddlewareFunction", testMiddlewareFunction),
    ("testDifferentMethods", testDifferentMethods),
    ("testSamePathDifferentiationByMethod", testSamePathDifferentiationByMethod),
    ("testMatchingWildcardComponents", testMatchingWildcardComponents),
    ("testTypesafePathParams", testTypesafePathParams),
    ("testTypesafeMultipleParams", testTypesafeMultipleParams),
    ("testMismatchingLongPaths", testMismatchingLongPaths),
    ("testMatchingWithAQuery", testMatchingWithAQuery),
  ]
}

XCTMain([
  testCase(CORSTests.allTests),
  testCase(FunctionTests.allTests),
  testCase(Titan404Tests.allTests),
  testCase(TitanAPITests.allTests),
  testCase(TitanErrorHandlingTests.allTests),
  testCase(TitanFormURLEncodedBodyParserTests.allTests),
  testCase(TitanHealthzTests.allTests),
  testCase(TitanJSONTests.allTests),
  testCase(TitanQueryStringTests.allTests),
  testCase(TitanRouterTests.allTests),
])

