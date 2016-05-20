//
//  UserManager.h
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface UserManager : NSObject

@property (nonatomic, strong, readonly) User *user;

+ (instancetype)sharedManager;

- (BOOL)isLoggedIn;
- (void)loginWithUsername:(NSString *)username;

@end
