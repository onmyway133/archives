//
//  FTGNumberRule.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGNumberRule.h"

@implementation FTGNumberRule

- (FTGNumberRule *(^)(NSNumber *anotherValue))equalTo {
    return ^(NSNumber *anotherValue){
        [self setValidation:^BOOL(NSNumber *value) {
            return [value isEqualToNumber:anotherValue];
        }];
        return self;
    };
}

- (FTGNumberRule *(^)(NSNumber *anotherValue))greaterThan {
    return ^(NSNumber *anotherValue){
        [self setValidation:^BOOL(NSNumber *value) {
            return [value compare:anotherValue] == NSOrderedDescending;
        }];
        return self;
    };
}

- (FTGNumberRule *(^)(NSNumber *anotherValue))lessThan {
    return ^(NSNumber *anotherValue){
        [self setValidation:^BOOL(NSNumber *value) {
            return [value compare:anotherValue] == NSOrderedAscending;
        }];
        return self;
    };
}

- (FTGNumberRule *(^)(NSNumber *number1, NSNumber *number2))between {
    return ^(NSNumber *number1, NSNumber *number2){
        [self setValidation:^BOOL(NSNumber *value) {
            return [value compare:number1] == NSOrderedDescending && [value compare:number2] == NSOrderedAscending;
        }];
        return self;
    };
}

@end
