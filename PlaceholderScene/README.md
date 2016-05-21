# PlaceholderScene
Mimicking storyboard reference through placeholder view controllers

[![CI Status](http://img.shields.io/travis/Khoa Pham/PlaceholderScene.svg?style=flat)](https://travis-ci.org/Khoa Pham/PlaceholderScene)
[![Version](https://img.shields.io/cocoapods/v/PlaceholderScene.svg?style=flat)](http://cocoapods.org/pods/PlaceholderScene)
[![License](https://img.shields.io/cocoapods/l/PlaceholderScene.svg?style=flat)](http://cocoapods.org/pods/PlaceholderScene)
[![Platform](https://img.shields.io/cocoapods/p/PlaceholderScene.svg?style=flat)](http://cocoapods.org/pods/PlaceholderScene)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Features
- Resolve placeholder view controllers
- Resolve child view controllers for `UITabBarController` and `UINavigationController`

### Storyboard setup
In one Storyboard, configure the placeholder view controller
![](./Screenshots/main.png)

And in the destination Storyboard, configure the Storyboard ID for the real view controller
![](./Screenshots/modal.png)

## Installation

PlaceholderScene is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PlaceholderScene"
```

## Author

Khoa Pham, onmyway133@gmail.com

## License

PlaceholderScene is available under the MIT license. See the LICENSE file for more info.
