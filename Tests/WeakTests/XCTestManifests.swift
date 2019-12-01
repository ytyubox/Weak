import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(WeakTests.allTests),
		testCase(UnownedTests.allTests)
    ]
}
#endif
