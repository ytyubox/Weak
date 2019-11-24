/// A type that wraps an `Object` with a `weak` binding.
public protocol WeakProtocol {
	
	/// The object type of `Self`.
	associatedtype Weaked: AnyObject
	
	/// The object of `self`.
	var object: Weaked? { get }
	var isRefering:Bool {get}
	
}
public struct Weak<Weaked: AnyObject>: WeakProtocol, ExpressibleByNilLiteral, CustomStringConvertible {
	
	/// The object of `self`.
	public weak var object: Weaked?
	
	/// A textual representation of this instance.
	public var description: String {
		if let object = object {
			return "Weak(" + String(reflecting: object) + ")"
		} else {
			return "nil"
		}
	}
	
	/// Creates an instance for an optional object.
	public init(_ object: Weaked? = nil) {
		self.object = object
	}
	
	/// Creates an instance initialized with `nil`.
	public init(nilLiteral: ()) {
		self.init()
	}
	
	public var isRefering:Bool {
		object != nil
	}
}

extension Weak: Hashable, Equatable where Weaked:Hashable {
	
}

extension Sequence where Iterator.Element: WeakProtocol {
	
	/// The objects within `self`.
	public var objects: [Iterator.Element.Weaked] {
		return compactMap { $0.object }
	}
	
}

extension Sequence where Iterator.Element: AnyObject {
	
	/// An array of weak references to the elements in `self`.
	public var weak: [Weak<Iterator.Element>] {
		return map(Weak.init)
	}
}
extension Array where Element:WeakProtocol {
	public mutating func clearupReleased() {
		for (i,v) in self.enumerated().reversed() {
			if !v.isRefering {
				remove(at: i)
			}
		}
	}
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <W1, W2>(lhs: W1?, rhs: W2?) -> Bool where  W1:WeakProtocol, W2:WeakProtocol {
	return lhs?.object === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <W: WeakProtocol>(lhs: W?, rhs: AnyObject?) -> Bool {
	return lhs?.object === rhs
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <W: WeakProtocol>(lhs: AnyObject?, rhs: W?) -> Bool {
	return lhs === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to the same object instance.
public func === <W: WeakProtocol, U: UnownedProtocol>(lhs: W?, rhs: U?) -> Bool {
	return lhs?.object === rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <W1: WeakProtocol, W2: WeakProtocol>(lhs: W1?, rhs: W2?) -> Bool {
	return lhs?.object !== rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <W: WeakProtocol>(lhs: W?, rhs: AnyObject?) -> Bool {
	return lhs?.object !== rhs
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <W: WeakProtocol>(lhs: AnyObject?, rhs: W?) -> Bool {
	return lhs !== rhs?.object
}

/// Returns a Boolean value indicating whether two references point to different object instances.
public func !== <W: WeakProtocol, U: UnownedProtocol>(lhs: W?, rhs: U?) -> Bool {
	return lhs?.object !== rhs?.object
}

// Returns a Boolean value indicating whether two weak objects are equal.
public func == <W: WeakProtocol>(lhs: W?, rhs: W?) -> Bool where W.Weaked: Equatable {
	return lhs?.object == rhs?.object
}

/// Returns a Boolean value indicating whether a weak object and an optional object are equal.
public func == <W: WeakProtocol>(lhs: W?, rhs: W.Weaked?) -> Bool where W.Weaked: Equatable {
	return lhs?.object == rhs
}

/// Returns a Boolean value indicating whether an optional object and a weak object are equal.
public func == <W: WeakProtocol>(lhs: W.Weaked?, rhs: W?) -> Bool where W.Weaked: Equatable {
	return lhs == rhs?.object
}

// Returns a Boolean value indicating whether two weak objects are not equal.
public func != <W: WeakProtocol>(lhs: W?, rhs: W?) -> Bool where W.Weaked: Equatable {
	return lhs?.object != rhs?.object
}

/// Returns a Boolean value indicating whether a weak object and an optional object are not equal.
public func != <W: WeakProtocol>(lhs: W?, rhs: W.Weaked?) -> Bool where W.Weaked: Equatable {
	return lhs?.object != rhs
}

/// Returns a Boolean value indicating whether an optional object and a weak object are not equal.
public func != <W: WeakProtocol>(lhs: W.Weaked?, rhs: W?) -> Bool where W.Weaked: Equatable {
	return lhs != rhs?.object
}
