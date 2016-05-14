# LeftPad
LeftPad in Swift

[![CI Status](http://img.shields.io/travis/onmyway133/LeftPad.svg?style=flat)](https://travis-ci.org/onmyway133/LeftPad)
[![Version](https://img.shields.io/cocoapods/v/LeftPad.svg?style=flat)](http://cocoadocs.org/docsets/LeftPad)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/LeftPad.svg?style=flat)](http://cocoadocs.org/docsets/LeftPad)
[![Platform](https://img.shields.io/cocoapods/p/LeftPad.svg?style=flat)](http://cocoadocs.org/docsets/LeftPad)

## Description

The story http://www.theregister.co.uk/2016/03/23/npm_left_pad_chaos/

## Usage

```swift
XCTAssert("foo".leftPad(5) == "  foo")
XCTAssert("foobar".leftPad(6) == "foobar")
XCTAssert("hello".leftPad(7, character: "☘") == "☘☘hello")
```

## Author

Khoa Pham, onmyway133@gmail.com

## Installation

**LeftPad** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LeftPad'
```

**LeftPad** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "onmyway133/LeftPad"
```

## Author

Khoa Pham, onmyway133@gmail.com

## Contributing

We would love you to contribute to **LeftPad**, check the [CONTRIBUTING](https://github.com/onmyway133/LeftPad/blob/master/CONTRIBUTING.md) file for more info.

## License

**LeftPad** is available under the MIT license. See the [LICENSE](https://github.com/onmyway133/LeftPad/blob/master/LICENSE.md) file for more info.
