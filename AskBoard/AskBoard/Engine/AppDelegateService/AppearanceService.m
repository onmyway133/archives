//
//  AppearanceService.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AppearanceService.h"

@implementation AppearanceService

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UINavigationBar appearance].barTintColor = [UIColor orangeColor];

    return YES;
}

@end
