# Weak

[![Build Status](https://travis-ci.com/ytyubox/Weak.svg?branch=master)](https://travis-ci.com/ytyubox/Weak)
[![Platform](https://img.shields.io/badge/platform-macos%20%7C%20ios%20%7C%20watchos%20%7C%20ipados%20%7C%20tvos-lightgrey)](https://github.com/ytyubox/Weak)
[![codecov](https://codecov.io/gh/ytyubox/Weak/branch/master/graph/badge.svg)](https://codecov.io/gh/ytyubox/Weak)
[![Swift](https://img.shields.io/badge/Swift-5-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11-blue.svg)](https://developer.apple.com/xcode)
[![SPM](https://img.shields.io/badge/SPM-Compatible-blue)](https://swift.org/package-manager)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)

Weak and Unowned as native Swift types. inspire by https://github.com/nvzqz/Weak

## The Problem

Swift allows for `weak` and `unowned` bindings to objects out-of-the-box, but they can't be used just anywhere.

1. They can't be used as associated values of enum cases.

2. They can't be passed as a parameter to a function, method, or initializer without increasing the reference count.

Weak solves these two problems by giving you full control over how you want to pass around `weak` or `unowned`
references.

## Installation

### Compatibility

- Platforms:
    - macOS 10.9+
    - iOS 8.0+
    - watchOS 2.0+
    - tvOS 9.0+
    - Linux
- Xcode 8.0
- Swift 3.0

### Install Using Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a
decentralized dependency manager for Swift.

1. Add the project to your `Package.swift`.

    ```swift
    import PackageDescription

    let package = Package(
        ...
        dependencies: [
          ...
            .Package(url: "https://github.com/ytyubox/Weak.git", from: "1.0.0"),
        ],
        targets: [
        .target(
            name: "...",
            dependencies: ["Weak"])
    )
    ```

2. Import the Weak module.

    ```swift
    import Weak
    ```
    
## Usage

### Weak References

A `Weak<T>` instance acts just how `weak var foo: T` would. When the reference count hits 0, the `object` property
becomes `nil`.

```swift
let weakRef: Weak<SomeClass>

do {
    let instance = SomeClass()
    weakRef = Weak(instance)
    print(weakRef.object == nil)  // false
}

print(weakRef.object == nil)  // true
```

### Unowned References

An `Unowned<T>` instance should only be used when it will not outlive the life of `object`. Otherwise, accessing
`object` will cause a crash, just like accessing any `unowned` reference after the reference count hits 0.

```swift
let unownedRef: Unowned<SomeClass>

do {
    let instance = SomeClass()
    unownedRef = Unowned(instance)
    print(unownedRef.object)  // SomeClass(...)
}

print(unownedRef.object)  // CRASHES
```

## License

Weak is released under the [MIT License](https://opensource.org/licenses/MIT).
