//
//  FTGBook.m
//  FTGValueTransformerDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGBook.h"
#import "NSValueTransformer+FTGTransformerAdditions.h"

@implementation FTGBook

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             };
}

+ (NSValueTransformer *)priceJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FTGNumberValueTransformerName];
}

@end
