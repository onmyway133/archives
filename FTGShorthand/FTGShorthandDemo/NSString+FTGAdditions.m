//
//  NSString+FTGAdditions.m
//  FTGShorthandDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "NSString+FTGAdditions.h"
#import "FTGShorthand.h"

@implementation NSString (FTGAdditions)

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
    [FTGShorthand setPrefix:@"ftg_"];
    [FTGShorthand supportShorthandMethodsForClass:self];
}

@end
