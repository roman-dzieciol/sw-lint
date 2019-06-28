import XCTest

import sw_lintTests

var tests = [XCTestCaseEntry]()
tests += sw_lintTests.allTests()
XCTMain(tests)
