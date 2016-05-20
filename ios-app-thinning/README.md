# ios-app-thinning
All about App Thinning

> The store and operating system optimize the installation of iOS, tvOS, and watchOS apps by tailoring app delivery to the capabilities of the user’s particular device, with minimal footprint

App Thinning is the combination of slicing, bitcode, and on-demand resources

# Slicing (iOS, tvOS)

> Slicing is the process of creating and delivering variants of the app bundle for different target devices. A variant contains only the executable architecture and resources that are needed for the target device. When the user installs an app, a variant for the user’s device is downloaded and installed.

### Xcode 
Xcode 7

### Settings
No setting

### iOS
iOS 9

> Sliced apps are supported on devices running 9.0 and later; otherwise, the store delivers universal apps to customers.

### watchOS
watchOS 2

### tvOS
tvOS

### Testing on Simulator/Device

> Xcode builds a variant of the app for the selected device type, improving the debug build time and allowing you to test variants locally.

### Enterprise Distribution
Works for App Store only

# Bitcode

> Including bitcode will allow Apple to re-optimize your app binary in the future without the need to submit a new version of your app to the store.

### Xcode 
Xcode 7

### Settings
Build Settings -> Enable Bitcode (ENABLE_BITCODE)

### iOS
iOS 9, Default, Optional

### watchOS
watchOS 2, Required

### tvOS
tvOS, Required

### Testing on Simulator/Device
No effect

### Enterprise Distribution
Works for App Store only
Should disable Bitcode
If Bitcode is enabled, your binary will contain both object code and Bitcode

# On-Demand Resources (iOS, tvOS)

> On-demand resources are resources—such as images and sounds—that you can tag with keywords and request in groups, by tag

### Xcode 
Xcode 7

### Settings
Build Settings -> Enable On Demand Resources (ENABLE_ON_DEMAND_RESOURCES)
Use by tagging resources

> You identify on-demand resources during development by assigning them one or more tags.

### iOS
iOS 9
Deployment target must be iOS 9

### watchOS
watchOS 2

### tvOS
tvOS

### Testing on Simulator/Device
Embed in the app bundle

### Enterprise Distribution

> You can host on-demand resources for your app on any compliant web server. Apps distributed through the App Store can host on-demand resources only during development and testing. Enterprise apps using in-house distribution can host during development and distribution.

# Reference

- [App Thinning (iOS, tvOS, watchOS)](https://developer.apple.com/library/watchos/documentation/IDEs/Conceptual/AppDistributionGuide/AppThinning/AppThinning.html)
- [Bitcode Demystified](http://lowlevelbits.org/bitcode-demystified/)
- [iOS9, bitcode in enterprise app](http://stackoverflow.com/questions/33051650/ios9-bitcode-in-enterprise-app)
- [What does ENABLE_BITCODE do in xcode 7?](http://stackoverflow.com/questions/30722606/what-does-enable-bitcode-do-in-xcode-7)
- [On-Demand Resources Essentials](https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/On_Demand_Resources_Guide/)
