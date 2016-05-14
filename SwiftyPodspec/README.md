# SwiftyPodspec
If [podspec](https://guides.cocoapods.org/syntax/podspec#specification) is written in Swift

[![CI Status](http://img.shields.io/travis/Khoa Pham/SwiftyPodspec.svg?style=flat)](https://travis-ci.org/Khoa Pham/SwiftyPodspec)
[![Version](https://img.shields.io/cocoapods/v/SwiftyPodspec.svg?style=flat)](http://cocoapods.org/pods/SwiftyPodspec)
[![License](https://img.shields.io/cocoapods/l/SwiftyPodspec.svg?style=flat)](http://cocoapods.org/pods/SwiftyPodspec)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyPodspec.svg?style=flat)](http://cocoapods.org/pods/SwiftyPodspec)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
let spec = Spec().configure {
    $0.name = "SwiftyPodspec"
    $0.version = Version(major: 0, minor: 1, patch: 0)
    $0.summary = "If podspec is written in Swift"
    $0.homepage = NSURL(string: "https://github.com/onmyway133/SwiftyPodspec")
    $0.license = .MIT
    $0.author = [Author(name: "Khoa Pham", email: "onmyway133@gmail.com")]
    $0.source = .Git(Source.SourceGit(url: NSURL(string: "https://github.com/onmyway133/SwiftyPodspec.git")!, tag: $0.version))
    $0.socialMediaURL = NSURL(string: "https://twitter.com/onmyway133")
    $0.platform = [Platform(type: .iOS, version: Version(major: 8, minor: 0))]
    $0.sourceFiles = ["Pod/Classes/**/*"]
    $0.frameworks = ["Foundation"]
    $0.dependencies = [Dependency(name: "Configurable", version: Version(major: 0, minor: 1, patch: 0))]
}
````

## Installation

SwiftyPodspec is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftyPodspec"
```

## Author

Khoa Pham, onmyway133@gmail.com

## License

SwiftyPodspec is available under the MIT license. See the LICENSE file for more info.
