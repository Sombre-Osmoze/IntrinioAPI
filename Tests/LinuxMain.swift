import XCTest

import IntrinioAPITests

var tests = [XCTestCaseEntry]()
tests += IntrinioAPITests.allTests()
tests += ForexTests.allTests()
tests += EndpointsTests.allTests()
XCTMain(tests)
