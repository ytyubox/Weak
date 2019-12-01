//
//  UnownedUnsafe.swift
//  
//
//  Created by 游宗諭 on 2019/12/1.
//

import Foundation

/// A wrapper around an `Object` with a `unowned(unsafe)` binding.
public struct UnownedUnsafe<UnowndObject: AnyObject>: UnownedProtocol, CustomStringConvertible {
	
	/// The object of `self`.
	public unowned(unsafe) var object: UnowndObject!
	
	/// A textual representation of this instance.
	public var description: String {
		"UnownedUnsafe(" + String(reflecting: object!) + ")"
	}
	
	/// Creates an instance for an object.
	public init(_ object: UnowndObject?) {
		self.object = object
	}
	
}
extension UnownedUnsafe: Hashable, Equatable where UnowndObject: Hashable {
	
}

extension Sequence where Iterator.Element: AnyObject {
	
	/// return An array of unowned references to the elements in `self`.
	public func unownedUnsafe() -> [UnownedUnsafe<Iterator.Element>] {
		map(UnownedUnsafe.init)
	}
	
}
