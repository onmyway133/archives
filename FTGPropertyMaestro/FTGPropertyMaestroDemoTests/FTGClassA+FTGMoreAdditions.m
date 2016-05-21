//
//  FTGClassA+FTGMoreAdditions.m
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/27/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGClassA+FTGMoreAdditions.h"
#import "FTGPropertyMaestro.h"

@implementation FTGClassA (FTGMoreAdditions)

@dynamic categoryMoreStrongProperty;

+ (void)load
{
    [FTGPropertyMaestro synthesizeClass:self propertyNames:@[ @"categoryMoreStrongProperty" ]];
}

@end
