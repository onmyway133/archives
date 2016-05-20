//
//  MTLModel+Additions.m
//  AskBoard
//
//  Created by Khoa Pham on 5/5/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "MTLModel+Additions.h"
#import <Mantle.h>

@implementation MTLModel (Additions)

- (NSDictionary *)ftg_toDictionary {
    return [MTLJSONAdapter JSONDictionaryFromModel:(id<MTLJSONSerializing>)self error:nil];
}

@end
