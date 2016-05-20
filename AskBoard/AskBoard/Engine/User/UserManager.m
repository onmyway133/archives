//
//  UserManager.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "UserManager.h"
#import "User.h"

static NSString *const kUserKey = @"kUserKey";

@interface UserManager ()

@property (nonatomic, strong, readwrite) User *user;

@end

@implementation UserManager

+ (instancetype)sharedManager {
    static UserManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance load];
    });

    return instance;
}

#pragma mark - Persistence
- (void)save {
    NSData *archived = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:archived forKey:kUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)load {
    NSData *archived = [[NSUserDefaults standardUserDefaults] objectForKey:kUserKey];
    if (archived) {
        self.user = [NSKeyedUnarchiver unarchiveObjectWithData:archived];
    }
}

#pragma mark - Logic
- (void)loginWithUsername:(NSString *)username {
    self.user = [[User alloc] init];
    self.user.username = username;

    [self save];
}

- (void)logout {
    self.user = nil;
    [self save];
}

#pragma mark - Query
- (BOOL)isLoggedIn {
    return self.user ? YES : NO;
}

@end
