FTGAppstoreVersionChecker
==
Simple way to check Appstore version


How I do it
--
- Use [iTunes Search API](https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html)
- Use AFNetworking 2 to do network request. I use Cocoapods so you have to run ``pod install`` first

How to use it
--
```
    FTGAppstoreVersionChecker *checker = [FTGAppstoreVersionChecker checker];

    self.checker.appStoreID = @"698488137";
    self.checker.applicationBundleID = @"com.dbs.homeconnect";
    self.checker.currentApplicationVersion = @"1.2";

    [self.checker checkForNewVersionOnAppStoreWithNewerBlock:^(NSString *appstoreVersion) {
        NSLog(@"There is newer version %@ on Appstore. Check it out", appstoreVersion);
    } failure:^(NSError *error) {
        NSLog(@"Error %@", error);
    }];
```

Licence
--
This project is released under the MIT license. See LICENSE.md.

Feedback
--
Contact me [onmyway133](https://twitter.com/onmyway133)