//
//  WeakTests.swift
//  
//
//  Created by 游宗諭 on 2019/11/24.
//

import XCTest
@testable import Weak

final class UnownedTests:XCTestCase {
	class PrintTarget{ var str:String = ""}
	class SomeClass:NSObject {
		var printTarget:PrintTarget
		var text:String
		init(printTarget:PrintTarget, text:String) {
			self.printTarget = printTarget
			self.text = text
		}
		deinit {
			print(text, terminator: "", to: &printTarget.str)
		}
	}
	
	func testUnowned() {
		let testString = "deinited"
		let unownedRef: Unowned<SomeClass>
		let printTarget = PrintTarget()
		do {
			let instance = SomeClass(printTarget: printTarget, text: testString)
			unownedRef = Unowned(instance)
			XCTAssertNotNil(unownedRef.object)
			XCTAssertEqual("Unowned(" + String(reflecting: instance) + ")", unownedRef.description)
		}
		XCTAssertEqual(printTarget.str, testString)
	}
	func testUnownedForSequence() {
		let expect = (0...9).map{_ in SomeClass(printTarget: UnownedTests.PrintTarget(), text: "")}
		let unownedArray = expect.unowned()
		XCTAssertEqual(expect, unownedArray.map{$0.object})
		XCTAssertEqual(expect, unownedArray.objects)
	}
	
	func testUnownEqual() {
		let object = SomeClass(printTarget: UnownedTests.PrintTarget(), text: "")
		let unowned1 = Unowned(object)
		let unowned2 = Unowned(object)
		let weak = Weak(object)
		
		XCTAssertTrue(unowned1 === unowned2)
		XCTAssertTrue(unowned1 === object)
		XCTAssertTrue(object === unowned1)
		XCTAssertTrue(unowned1 === weak)
		XCTAssertTrue(unowned1 == unowned2)
		XCTAssertTrue(unowned1 == object)
		XCTAssertTrue(object == unowned1)
		XCTAssertFalse(unowned1 !== unowned2)
		XCTAssertFalse(unowned1 !== object)
		XCTAssertFalse(object !== unowned1)
		XCTAssertFalse(unowned1 !== weak)
		
			
		
	}
	func testOptionalUnownedEqual() {
		let object:SomeClass? = SomeClass(printTarget: UnownedTests.PrintTarget(), text: "")
		let unowned1:Unowned<SomeClass>? = Unowned(object)
		let unowned2:Unowned<SomeClass>? = Unowned(object)
		let weak:Weak<SomeClass>? = Weak(object)
		XCTAssertTrue(unowned1 === unowned2)
		XCTAssertTrue(unowned1 === object)
		XCTAssertTrue(object === unowned1)
		XCTAssertTrue(unowned1 === weak)
		XCTAssertTrue(unowned1 == unowned2)
		XCTAssertTrue(unowned1 == object)
		XCTAssertTrue(object == unowned1)
		XCTAssertTrue(unowned1 == weak)
		XCTAssertFalse(unowned1 !== unowned2)
		XCTAssertFalse(unowned1 !== object)
		XCTAssertFalse(object !== unowned1)
		XCTAssertFalse(unowned1 !== weak)
		XCTAssertFalse(unowned1 != unowned2)
		XCTAssertFalse(unowned1 != object)
		XCTAssertFalse(object != unowned1)
		XCTAssertFalse(unowned1 != weak)
	}
}
