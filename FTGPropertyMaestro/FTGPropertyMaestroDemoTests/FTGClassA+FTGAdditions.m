//
//  FTGClassA+FTGAdditions.m
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/27/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGClassA+FTGAdditions.h"
#import "FTGPropertyMaestro.h"

@implementation FTGClassA (FTGAdditions)

@dynamic categoryBoolProperty;
@dynamic categoryCopyProperty;
@dynamic categoryStrongProperty;

- (BOOL)fetchCategoryBoolProperty
{
    // Property not of object type is not supported
    return YES;
}

- (void)setCategoryBoolProperty:(BOOL)categoryBoolProperty
{
    // Property not of object type is not supported
}

+ (void)load
{
    [FTGPropertyMaestro synthesizeClass:self propertyNames:@[ @"categoryCopyProperty", @"categoryStrongProperty"] ];
}

@end
