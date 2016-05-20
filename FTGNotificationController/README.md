FTGNotificationController
=========
Simple and safe way to observe notification

How I do it
--
- Modify Facebook 's KVOController to work with NSNotificationCenter

How to use it
--
- Example
```
self.notificationController = [FTGNotificationController controllerWithObserver:self];
    [self.notificationController observeNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil
                                                   queue:[NSOperationQueue mainQueue]
                                                   block:^(NSNotification *note, id observer)
    {
        NSLog(@"observer %@ notification payload %@", observer, note);
    }];
```
- To automatically remove observers on observer dealloc, declare FTGNotificationController as strong property
- Do not use self inside block as it causes retain cycle. Declare weak self or use observer parameter (declared as weak for you)

Installation
--
There are 2 ways
- Drag FTGNotificationController.h and .FTGNotificationController.m files to your project
- Using Cocoapods
```
  pod 'FTGNotificationController'
```
or 
```
pod 'FTGNotificationController', :git => 'https://github.com/onmyway133/FTGNotificationController.git'
```


Testing
--
- Use Kiwi/XCTest

Reference
--
1. [NSNotificationCenter with blocks considered harmful](http://sealedabstract.com/code/nsnotificationcenter-with-blocks-considered-harmful/)

