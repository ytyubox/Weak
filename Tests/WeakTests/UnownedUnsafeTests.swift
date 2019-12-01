//
//  UnownedUnsafeTests.swift
//  
//
//  Created by 游宗諭 on 2019/12/1.
//

import XCTest
import Weak

final class UnownedUnsafeTests:XCTestCase {
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
	
	func testUnownedunsafe() {
		let testString = "deinited"
		let UnownedunsafeRef: UnownedUnsafe<SomeClass>
		let printTarget = PrintTarget()
		do {
			let instance = SomeClass(printTarget: printTarget, text: testString)
			UnownedunsafeRef = UnownedUnsafe(instance)
			XCTAssertNotNil(UnownedunsafeRef.object)
			XCTAssertEqual("UnownedUnsafe(" + String(reflecting: instance) + ")", UnownedunsafeRef.description)
		}
		XCTAssertEqual(printTarget.str, testString)
	}
	func testUnownedunsafeForSequence() {
		let expect = (0...9).map{_ in SomeClass(printTarget: UnownedUnsafeTests.PrintTarget(), text: "")}
		let UnownedunsafeArray = expect.unownedUnsafe()
		XCTAssertEqual(expect, UnownedunsafeArray.map{$0.object})
		XCTAssertEqual(expect, UnownedunsafeArray.objects)
	}
	
	func testUnownEqual() {
		let object = SomeClass(printTarget: UnownedUnsafeTests.PrintTarget(), text: "")
		let Unownedunsafe1 = UnownedUnsafe(object)
		let Unownedunsafe2 = UnownedUnsafe(object)
		let weak = Weak(object)
		
		XCTAssertTrue(Unownedunsafe1 === Unownedunsafe2)
		XCTAssertTrue(Unownedunsafe1 === object)
		XCTAssertTrue(object === Unownedunsafe1)
		XCTAssertTrue(Unownedunsafe1 === weak)
		XCTAssertTrue(Unownedunsafe1 == Unownedunsafe2)
		XCTAssertTrue(Unownedunsafe1 == object)
		XCTAssertTrue(object == Unownedunsafe1)
		XCTAssertFalse(Unownedunsafe1 !== Unownedunsafe2)
		XCTAssertFalse(Unownedunsafe1 !== object)
		XCTAssertFalse(object !== Unownedunsafe1)
		XCTAssertFalse(Unownedunsafe1 !== weak)
		
		
		
	}
	func testOptionalUnownedunsafeEqual() {
		let object:SomeClass? = SomeClass(printTarget: UnownedUnsafeTests.PrintTarget(), text: "")
		let Unownedunsafe1:UnownedUnsafe<SomeClass>? = UnownedUnsafe(object)
		let Unownedunsafe2:UnownedUnsafe<SomeClass>? = UnownedUnsafe(object)
		let weak:Weak<SomeClass>? = Weak(object)
		XCTAssertTrue(Unownedunsafe1 === Unownedunsafe2)
		XCTAssertTrue(Unownedunsafe1 === object)
		XCTAssertTrue(object === Unownedunsafe1)
		XCTAssertTrue(Unownedunsafe1 === weak)
		XCTAssertTrue(Unownedunsafe1 == Unownedunsafe2)
		XCTAssertTrue(Unownedunsafe1 == object)
		XCTAssertTrue(object == Unownedunsafe1)
		XCTAssertTrue(Unownedunsafe1 == weak)
		XCTAssertFalse(Unownedunsafe1 !== Unownedunsafe2)
		XCTAssertFalse(Unownedunsafe1 !== object)
		XCTAssertFalse(object !== Unownedunsafe1)
		XCTAssertFalse(Unownedunsafe1 !== weak)
		XCTAssertFalse(Unownedunsafe1 != Unownedunsafe2)
		XCTAssertFalse(Unownedunsafe1 != object)
		XCTAssertFalse(object != Unownedunsafe1)
		XCTAssertFalse(Unownedunsafe1 != weak)
	}
}
