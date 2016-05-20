//
//  Answer.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "Answer.h"
#import "User.h"

@implementation Answer

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"user": @"user",
             @"content": @"content",
             };
}

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:User.class];
}

@end
