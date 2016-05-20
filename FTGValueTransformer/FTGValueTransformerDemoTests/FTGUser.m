//
//  FTGUser.m
//  FTGValueTransformerDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGUser.h"
#import "NSValueTransformer+FTGTransformerAdditions.h"
#import "FTGBook.h"

@implementation FTGUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"favoriteBook": @"books"
             };
}

+ (NSValueTransformer *)scoreJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

+ (NSValueTransformer *)favoriteBookJSONTransformer
{
    return [NSValueTransformer ftg_JSONFirstObjectInArrayTransformerWithModelClass:FTGBook.class];
}

@end
