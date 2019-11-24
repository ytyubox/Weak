import XCTest
@testable import Weak

final class WeakTests: XCTestCase {
	class SomeClass:NSObject { }
	
	func testWeakInit() {
		let weak:Weak<SomeClass> = nil
		XCTAssertNil(weak.object)
	}
	func testWeak() {
		let weakRef: Weak<SomeClass>
		do {
			let instance = SomeClass()
			weakRef = Weak(instance)
			XCTAssertNotNil(weakRef.object)
		}
		XCTAssertNil(weakRef.object)
	}
	func testSetClearupReleased() {
		var list = Array<Weak<SomeClass>>()
		for _ in 0...4 {
			let instance = SomeClass()
			let weakRef = Weak(instance)
			list.append(weakRef)
		}
		list.clearupReleased()
		XCTAssertEqual(list.count, 0)
	}
	func testWeakSequence() {
		let origin = (0...10)
		let objectList = origin.map{_ in SomeClass()}
		let weakList = objectList.weak
		XCTAssertEqual(weakList.count, origin.count)
		XCTAssertEqual(weakList.objects, objectList)
	}
	func testWeak3Equal() {
		let object = SomeClass()
		let w1 = Weak(object)
		var w2 = Weak(object)
		var unowned = Unowned(object)
		XCTAssertTrue(w1 === w2)
		XCTAssertTrue(w1 === object)
		XCTAssertTrue(object === w1)
		XCTAssertTrue(w1 === unowned)
		let object2 = SomeClass()
		w2.object = object2
		unowned.object = object2
		
		XCTAssertTrue(w1 !== w2)
		XCTAssertTrue(w1 !== object2)
		XCTAssertTrue(object2 !== w1)
		XCTAssertTrue(w1 !== unowned)
	}
	
	func testWeakString() {
		let weakRef: Weak<SomeClass>

		do {
			let instance = SomeClass()
			weakRef = Weak(instance)
			
			XCTAssertEqual(weakRef.description, "Weak(\(String(reflecting: instance)))")
		}
		XCTAssertEqual(weakRef.description, "nil")
	}
	//	static var allTests = [
	//		("testweak", testWeak),
	//		("testSetClearupReleased", testSetClearupReleased),
	//	]
}
