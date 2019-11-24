import XCTest
@testable import Weak

final class WeakTests: XCTestCase {
	class SomeClass:NSObject { }
    func testWeak() {
		let weakRef: Weak<SomeClass>
		do {
			let instance = SomeClass()
			weakRef = Weak(instance)
			XCTAssertNotNil(weakRef.object)
		}
		XCTAssertNil(weakRef.object)
    }

    static var allTests = [
        ("testExample", testWeak),
    ]
}
