# SQLiteStack
A simple SQLite Stack

[![CI Status](http://img.shields.io/travis/Khoa Pham/SQLiteStack.svg?style=flat)](https://travis-ci.org/Khoa Pham/SQLiteStack)
[![Version](https://img.shields.io/cocoapods/v/SQLiteStack.svg?style=flat)](http://cocoapods.org/pods/SQLiteStack)
[![License](https://img.shields.io/cocoapods/l/SQLiteStack.svg?style=flat)](http://cocoapods.org/pods/SQLiteStack)
[![Platform](https://img.shields.io/cocoapods/p/SQLiteStack.svg?style=flat)](http://cocoapods.org/pods/SQLiteStack)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### How it works
- Prefer protocol over inheritance via `FTGSQLiteSerializing`
- Inspect model properties via `FTGModelHelper`
- Convert model into SQLite statements via `FTGSQLiteHelper`
- Create tables, execute statements via `FTGSQLiteStack`

### Example

`Model`
```objc
#import <Foundation/Foundation.h>
#import "FTGSQLiteSerializing.h"

@interface FTGNote : NSObject <FTGSQLiteSerializing>

@property (nonatomic, copy) NSString *modelID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic) NSTimeInterval timeInterval;

@end
```

```objc
@implementation FTGNote

+ (NSArray<NSString *> *)propertyKeys {
    return @[@"modelID",
             @"content",
             @"timeInterval",
             ];
}

@end
```

`DataManager`
```objc
@implementation FTGDataManager

- (FTGNote *)createNoteWithContent:(NSString *)content {
    FTGNote *note = [[FTGNote alloc] init];
    note.modelID = [[NSUUID UUID] UUIDString];
    note.content = content;
    note.timeInterval = [[NSDate date] timeIntervalSince1970];

    return note;
}

- (void)saveNotes:(NSArray<FTGNote *> *)notes {
    FTGSQLiteHelper *helper = [FTGSQLiteHelper new];
    NSArray<NSString *> *modifiedStatements = [notes map:^id(FTGNote *note) {
        return [helper insertOrUpdateStatementForModel:note modelClass:[FTGNote class]];
    }];

    [self.stack executeStatements:modifiedStatements];
}

- (NSArray<FTGNote *> *)loadNotes {
    return (id)[self.stack loadAllWithModelClass:[FTGNote class]];
}

@end
```

## Installation

SQLiteStack is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SQLiteStack"
```

## Author

Khoa Pham, onmyway133@gmail.com

## License

SQLiteStack is available under the MIT license. See the LICENSE file for more info.
