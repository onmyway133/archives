//
//  FTGAppstoreVersionChecker.m
//  FTGAppstoreVersionCheckerDemo
//
//  Created by Khoa Pham on 6/18/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGAppstoreVersionChecker.h"
#import <AFNetworking/AFNetworking.h>

NSString *const kiTunesBaseURLString = @"http://itunes.apple.com";

@interface FTGAppstoreVersionChecker ()

@property (nonatomic, copy) FTGAppstoreVersionCheckerNewerBlock newerBlock;
@property (nonatomic, copy) FTGAppstoreVersionCheckerFailureBlock failureBlock;

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation FTGAppstoreVersionChecker

#pragma mark - Factory
+ (FTGAppstoreVersionChecker *)checker
{
    FTGAppstoreVersionChecker *checker = [[FTGAppstoreVersionChecker alloc] init];
    checker.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kiTunesBaseURLString]];

    checker.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    checker.manager.responseSerializer = [AFJSONResponseSerializer serializer];

    return checker;
}

#pragma mark - Public interface
- (void)checkForNewVersionOnAppStoreWithNewerBlock:(FTGAppstoreVersionCheckerNewerBlock)newerBlock
                                           failure:(FTGAppstoreVersionCheckerFailureBlock)failureBlock;
{
    self.newerBlock = newerBlock;
    self.failureBlock = failureBlock;

    [self.manager GET:[self requestPath]
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [self handleOperation:operation
                     response:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

#pragma mark - Handle response
- (void)handleOperation:(AFHTTPRequestOperation *)operation
               response:(NSDictionary *)responseObject
{
    if (operation.response.statusCode != 200) {
        [self notifyAboutError:@"Network request failed"];
        return;
    }

    if (![responseObject objectForKey:@"resultCount"] || ![responseObject objectForKey:@"results"]) {
        [self notifyAboutError:@"Network response is not correct"];
        return;
    }

    NSDictionary *result = [responseObject[@"results"]  lastObject];

    // If user explicitly specify appstoreID or applicationBundleID, check to make sure the result is for our app
    if (![self checkForMatchingApplicationInfo:result]) {
        [self notifyAboutError:@"Network response is not for this app"];
        return;
    }

    if (!self.appStoreID) {
        self.appStoreID = [responseObject[@"trackId"] stringValue];
    }

    // Check version
    NSString *appStoreVersion = result[@"version"];
    if ([appStoreVersion compare:[self findCurrentApplicationVersion] options:NSNumericSearch] == NSOrderedDescending) {
        [self notifyAboutNewerVersion:appStoreVersion];
    }
}

- (void)notifyAboutNewerVersion:(NSString *)appStoreVersion
{
    if (self.newerBlock) {
        self.newerBlock(appStoreVersion);
    }
}

- (void)notifyAboutError:(NSString *)errorReason
{
    NSError *error = [NSError errorWithDomain:@"FTGErrorDomain"
                                         code:0
                                     userInfo:@{NSLocalizedDescriptionKey: errorReason
                                                }];

    if (self.failureBlock) {
        self.failureBlock(error);
    }
}

#pragma mark - iTunes search path
- (NSString *)requestPath
{
    NSString *lookupPath = nil;

    // Prefer search by appStoreID, then bundleID
    if (self.appStoreID) {
        lookupPath =  [NSString stringWithFormat:@"lookup?id=%@", self.appStoreID];
    } else {
        self.applicationBundleID = self.applicationBundleID ?: [[NSBundle mainBundle] bundleIdentifier];
        lookupPath = [NSString stringWithFormat:@"lookup?bundleId=%@", self.applicationBundleID];
    }

    return [NSString stringWithFormat:@"/%@/%@", [self appStoreCountry], lookupPath];
}

- (NSString *)appStoreCountry
{
    NSString *appStoreCountry = nil;

    appStoreCountry = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    if ([appStoreCountry isEqualToString:@"150"])
    {
        appStoreCountry = @"eu";
    }
    else if ([[appStoreCountry stringByReplacingOccurrencesOfString:@"[A-Za-z]{2}" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, 2)] length])
    {
        appStoreCountry = @"us";
    }

    return appStoreCountry;
}

#pragma mark - Version compare
- (NSString *)findCurrentApplicationVersion
{
    if (self.currentApplicationVersion) {
        return self.currentApplicationVersion;
    }

    NSString *applicationVersion = nil;

    // Prefere short version string
    applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if ([applicationVersion length] == 0)
    {
        applicationVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    }
    
    return applicationVersion;
}

- (BOOL)checkForMatchingApplicationInfo:(NSDictionary *)result
{
    if (self.appStoreID && ![[result[@"trackId"] stringValue] isEqualToString:self.appStoreID]) {
        return NO;
    }

    if (self.applicationBundleID && ![result[@"bundleId"] isEqualToString:self.applicationBundleID]) {
        return NO;
    }

    return YES;
}

#pragma mark - Open app in Appstore
- (void)openAppInAppStore
{
    NSString *appLinkInAppStore = [NSString stringWithFormat:@"%@/app/id%@", kiTunesBaseURLString, self.appStoreID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appLinkInAppStore]];
}

@end
