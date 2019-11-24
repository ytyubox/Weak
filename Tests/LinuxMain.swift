import XCTest

import WeakTests

var tests = [XCTestCaseEntry]()
tests += WeakTests.allTests()
XCTMain(tests)
