import XCTest

import IntrinioTests
import IntrinioAPITests

var tests = [XCTestCaseEntry]()
tests += IntrinioTests.allTests()
tests += IntrinioAPITests.allTests()
XCTMain(tests)
