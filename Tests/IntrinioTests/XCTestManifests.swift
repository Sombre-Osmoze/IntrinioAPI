import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(ForexTests.allTests),
		testCase(EndpointsTests.allTests)
	]
}
#endif
