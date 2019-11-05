import XCTest

import IntrinioAPITests

var tests = [XCTestCaseEntry]()
tests += IntrinioAPITests.allTests()
tests += ForexTests.allTests()
XCTMain(tests)
