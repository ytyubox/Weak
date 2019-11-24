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
		}
		XCTAssertEqual(printTarget.str, testString)
	}
	
	static var allTests = [
		("testUnowned", testUnowned),
	]
	
}
