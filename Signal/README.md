# Signal
A simple Signal

[![CI Status](http://img.shields.io/travis/Khoa Pham/Signal.svg?style=flat)](https://travis-ci.org/Khoa Pham/Signal)
[![Version](https://img.shields.io/cocoapods/v/Signal.svg?style=flat)](http://cocoapods.org/pods/Signal)
[![License](https://img.shields.io/cocoapods/l/Signal.svg?style=flat)](http://cocoapods.org/pods/Signal)
[![Platform](https://img.shields.io/cocoapods/p/Signal.svg?style=flat)](http://cocoapods.org/pods/Signal)

## Usage

See the post [Push vs Pull signal](http://www.fantageek.com/blog/2016/01/03/push-vs-pull-signal/)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
let s = Signal<String>()

s.subscribeNext { value in
    print(value)
}

s.sendNext("Happy New Year")
```

## Installation

Signal is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Signal"
```

## Credit
Credit goes to 

- [UIKonf 2015 - Jens Ravens: Functional Reactive Programming without Black Magic](https://www.youtube.com/watch?v=AcDaWe3S75c)
- [Swift Sync and Async Error Handling - iOS Conf SG 2015](https://www.youtube.com/watch?v=mbd6g7NfR-8)

## Author

Khoa Pham, onmyway133@gmail.com

## License

Signal is available under the MIT license. See the LICENSE file for more info.
