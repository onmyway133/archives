//
//  AppDelegate.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AppDelegate.h"
#import "RootService.h"
#import "AppearanceService.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSArray *services;

@end

@implementation AppDelegate

- (NSArray *)services {
    if (!_services) {
        _services = @[[AppearanceService new],
                      [RootService new],
                      ];
    }

    return _services;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    id<UIApplicationDelegate> service;
    for(service in self.services){
        if ([service respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]){
            [service application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    id<UIApplicationDelegate> service;
    for(service in self.services){
        if ([service respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]){

            if ([service application:application openURL:url sourceApplication:sourceApplication annotation:annotation]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    id<UIApplicationDelegate> service;
    for(service in self.services){
        if ([service respondsToSelector:@selector(applicationWillResignActive:)]) {
            [service applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    id<UIApplicationDelegate> service;
    for(service in self.services){
        if ([service respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [service applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    id<UIApplicationDelegate> service;
    for(service in self.services){
        if ([service respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [service applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    id<UIApplicationDelegate> service;
    for(service in self.services){
        if ([service respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [service applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
