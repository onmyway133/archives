# Cine

[![CI Status](http://img.shields.io/travis/Khoa Pham/Cine.svg?style=flat)](https://travis-ci.org/Khoa Pham/Cine)
[![Version](https://img.shields.io/cocoapods/v/Cine.svg?style=flat)](http://cocoapods.org/pods/Cine)
[![License](https://img.shields.io/cocoapods/l/Cine.svg?style=flat)](http://cocoapods.org/pods/Cine)
[![Platform](https://img.shields.io/cocoapods/p/Cine.svg?style=flat)](http://cocoapods.org/pods/Cine)

![cine](Cine.png)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
layer = AVPlayerLayer()
view.layer.insertSublayer(layer, atIndex: 0)

player = Player(option: Option.defaultOption(), layer: layer)
player.addDelegate(self)

if let url = NSURL(string: "https://clips.vorwaerts-gmbh.de/VfE_html5.mp4") {
	player.play(url)
}
```

## Installation

Cine is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Cine"
```

## Author

Khoa Pham, onmyway133@gmail.com

## License

Cine is available under the MIT license. See the LICENSE file for more info.
