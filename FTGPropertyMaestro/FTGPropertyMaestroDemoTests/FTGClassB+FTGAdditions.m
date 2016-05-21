//
//  FTGClassB+FTGAdditions.m
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/27/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGClassB+FTGAdditions.h"
#import "FTGPropertyMaestro.h"

@implementation FTGClassB (FTGAdditions)

@dynamic categoryWeakProperty;
@dynamic categoryCanBeNilProperty;

+ (void)load
{
    [FTGPropertyMaestro synthesizeClass:self propertyNamesWithPrefix:@"category"];
}

@end
