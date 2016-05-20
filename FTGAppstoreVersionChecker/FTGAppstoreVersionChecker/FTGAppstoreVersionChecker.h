//
//  FTGAppstoreVersionChecker.h
//  FTGAppstoreVersionCheckerDemo
//
//  Created by Khoa Pham on 6/18/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FTGAppstoreVersionCheckerNewerBlock)(NSString *appstoreVersion);
typedef void (^FTGAppstoreVersionCheckerFailureBlock)(NSError *error);

@interface FTGAppstoreVersionChecker : NSObject

@property (nonatomic, copy) NSString *appStoreID;
@property (nonatomic, copy) NSString *applicationBundleID;
@property (nonatomic, copy) NSString *currentApplicationVersion;

+ (FTGAppstoreVersionChecker *)checker;

- (void)checkForNewVersionOnAppStoreWithNewerBlock:(FTGAppstoreVersionCheckerNewerBlock)newerBlock
                                           failure:(FTGAppstoreVersionCheckerFailureBlock)failureBlock;

@end
