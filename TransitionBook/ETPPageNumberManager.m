//
//  ETPPageNumberManager.m
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ETPPageNumberManager.h"

static NSUInteger kMaxPageNumber = 8;

@implementation ETPPageNumberManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static ETPPageNumberManager *sharedInstance;

    dispatch_once(&once, ^{
        sharedInstance = [[ETPPageNumberManager alloc] init];
    });

    return sharedInstance;
}

- (void)increase
{
    _pageNumber++;
}

- (void)decrease
{
    _pageNumber--;
}

- (BOOL)isMaxPage
{
    return _pageNumber == kMaxPageNumber;
}

@end
