//
//  Unowned.swift
//  
//
//  Created by 游宗諭 on 2019/11/24.
//


/// A wrapper around an `Object` with a `unowned` binding.
public struct Unowned<Object: AnyObject>: UnownedProtocol, CustomStringConvertible {
	
	/// The object of `self`.
	public unowned var object: Object
	
	/// A textual representation of this instance.
	public var description: String {
		return "Unowned(" + String(reflecting: object) + ")"
	}
	
	/// Creates an instance for an object.
	public init(_ object: Object) {
		self.object = object
	}
	
}

/// A type that wraps an `Object` with an `unowned` binding.
public protocol UnownedProtocol {
	
	/// The object type of `Self`.
	associatedtype Object: AnyObject
	
	/// The object of `self`.
	var object: Object { get }
	
}

extension Sequence where Iterator.Element: UnownedProtocol {
	
	/// The objects within `self`.
	public var objects: [Iterator.Element.Object] {
		return map { $0.object }
	}
	
}

extension Sequence where Iterator.Element: AnyObject {
	
	/// An array of unowned references to the elements in `self`.
	public var unowned: [Unowned<Iterator.Element>] {
		return map(Unowned.init)
	}
	
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <U1: UnownedProtocol, U2: UnownedProtocol>(lhs: U1?, rhs: U2?) -> Bool {
	return lhs?.object === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <U: UnownedProtocol>(lhs: U?, rhs: AnyObject?) -> Bool {
	return lhs?.object === rhs
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <U: UnownedProtocol>(lhs: AnyObject?, rhs: U?) -> Bool {
	return lhs === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <U: UnownedProtocol, W: WeakProtocol>(lhs: U?, rhs: W?) -> Bool {
	return lhs?.object === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <U1: UnownedProtocol, U2: UnownedProtocol>(lhs: U1?, rhs: U2?) -> Bool {
	return lhs?.object !== rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <U: UnownedProtocol>(lhs: U?, rhs: AnyObject?) -> Bool {
	return lhs?.object !== rhs
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <U: UnownedProtocol>(lhs: AnyObject?, rhs: U?) -> Bool {
	return lhs !== rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <U: UnownedProtocol, W: WeakProtocol>(lhs: U?, rhs: W?) -> Bool {
	return lhs?.object !== rhs?.object
}

/// Returns a Boolean value indicating whether two unowned objects are equal.
public func == <U: UnownedProtocol>(lhs: U?, rhs: U?) -> Bool where U.Object: Equatable {
	return lhs?.object == rhs?.object
}

/// Returns a Boolean value indicating whether an unowned object and an optional object are equal.
public func == <U: UnownedProtocol>(lhs: U?, rhs: U.Object?) -> Bool where U.Object: Equatable {
	return lhs?.object == rhs
}

/// Returns a Boolean value indicating whether an optional object and an unowned object are equal.
public func == <U: UnownedProtocol>(lhs: U.Object?, rhs: U?) -> Bool where U.Object: Equatable {
	return lhs == rhs?.object
}

/// Returns a Boolean value indicating whether two unowned objects are not equal.
public func != <U: UnownedProtocol>(lhs: U?, rhs: U?) -> Bool where U.Object: Equatable {
	return lhs?.object != rhs?.object
}

/// Returns a Boolean value indicating whether an unowned object and an optional object are not equal.
public func != <U: UnownedProtocol>(lhs: U?, rhs: U.Object?) -> Bool where U.Object: Equatable {
	return lhs?.object != rhs
}

/// Returns a Boolean value indicating whether an optional object and an unowned object are not equal.
public func != <U: UnownedProtocol>(lhs: U.Object?, rhs: U?) -> Bool where U.Object: Equatable {
	return lhs != rhs?.object
}
