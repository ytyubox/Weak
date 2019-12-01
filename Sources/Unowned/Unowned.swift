//
//  Unowned.swift
//  
//
//  Created by 游宗諭 on 2019/11/24.
//

/// A type that wraps an `Object` with an `unowned` binding.
public protocol UnownedProtocol {
	
	/// The object type of `Self`.
	associatedtype UnownedObject: AnyObject
	
	/// The object of `self`.
	var object: UnownedObject! { get }
	
}

/// A wrapper around an `Object` with a `unowned` binding.
public struct Unowned<UnowndObject: AnyObject>: UnownedProtocol, CustomStringConvertible {
	
	/// The object of `self`.
	public unowned(safe) var object: UnowndObject!
	
	/// A textual representation of this instance.
	public var description: String {
		"Unowned(" + String(reflecting: object!) + ")"
	}
	
	/// Creates an instance for an object.
	public init(_ object: UnowndObject?) {
		self.object = object
	}
	
}
extension Unowned: Hashable, Equatable where UnowndObject: Hashable {
	
}

extension Sequence where Iterator.Element: UnownedProtocol {
	
	/// The objects within `self`.
	public var objects: [Iterator.Element.UnownedObject] {
		map { $0.object }
	}
	
}

extension Sequence where Iterator.Element: AnyObject {
	
	/// return An array of unowned references to the elements in `self`.
	public func unowned() -> [Unowned<Iterator.Element>] {
		map(Unowned.init)
	}
	
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <U1, U2>(lhs: U1?, rhs: U2?) -> Bool where U1: UnownedProtocol, U2:UnownedProtocol {
	lhs?.object === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <U>(lhs: U?, rhs: AnyObject?) -> Bool where U: UnownedProtocol {
	 lhs?.object === rhs
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <U>(lhs: AnyObject?, rhs: U?) -> Bool where U: UnownedProtocol {
	 lhs === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <U: UnownedProtocol, W: WeakProtocol>(lhs: U?, rhs: W?) -> Bool {
	 lhs?.object === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <U1: UnownedProtocol, U2: UnownedProtocol>(lhs: U1?, rhs: U2?) -> Bool {
	 lhs?.object !== rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <U>(lhs: U?, rhs: AnyObject?) -> Bool  where U: UnownedProtocol {
	lhs?.object !== rhs
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <U>(lhs: AnyObject?, rhs: U?) -> Bool  where U: UnownedProtocol {
	lhs !== rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <U, W>(lhs: U?, rhs: W?) -> Bool where U: UnownedProtocol, W: WeakProtocol {
	lhs?.object !== rhs?.object
}


/// Returns a Boolean value indicating whether an unowned object and an optional object are equal.
public func == <U>(lhs: U?, rhs: U.UnownedObject?) -> Bool where U:UnownedProtocol, U.UnownedObject: Equatable {
	lhs?.object == rhs
}

/// Returns a Boolean value indicating whether an optional object and an unowned object are equal.
public func == <U>(lhs: U.UnownedObject?, rhs: U?) -> Bool where U:UnownedProtocol, U.UnownedObject: Equatable {
	lhs == rhs?.object
}
public func == <U,W>(lhs: U?, rhs: W?) -> Bool where U:UnownedProtocol, U.UnownedObject: Equatable, W:WeakProtocol, U.UnownedObject == W.Weaked {
	lhs?.object == rhs?.object
}


/// Returns a Boolean value indicating whether an unowned object and an optional object are not equal.
public func != <U>(lhs: U?, rhs: U.UnownedObject?) -> Bool where U:UnownedProtocol, U.UnownedObject: Equatable {
	lhs?.object != rhs
}

public func != <U>(lhs: U.UnownedObject?, rhs: U?) -> Bool where U:UnownedProtocol, U.UnownedObject: Equatable {
	lhs != rhs?.object
}

public func != <U, W>(lhs: U?, rhs: W?) -> Bool where U:UnownedProtocol, U.UnownedObject: Equatable, W:WeakProtocol, U.UnownedObject == W.Weaked{
	lhs?.object != rhs?.object
}
