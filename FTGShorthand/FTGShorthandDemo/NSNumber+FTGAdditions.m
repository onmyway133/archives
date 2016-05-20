//
//  NSNumber+FTGAdditions.m
//  FTGShorthandDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "NSNumber+FTGAdditions.h"
#import "FTGShorthand.h"

@implementation NSNumber (FTGAdditions)

- (void)ftg_doSomething1
{
    NSLog(@"doSomething1 on %@", self);
}

- (void)ftg_doSomething2
{
    NSLog(@"doSomething2 on %@", self);
}

#pragma mark - FTGShorthand
+ (void)load
{
    [FTGShorthand supportShorthandMethodsForClass:self];
}

@end
