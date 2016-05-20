//
//  FTGDateRule.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGDateRule.h"

@implementation FTGDateRule

- (FTGDateRule *(^)(NSDate *anotherValue))equalTo {
    return ^(NSDate *anotherValue){
        [self setValidation:^BOOL(NSDate *value) {
            return [value isEqualToDate:anotherValue];
        }];
        return self;
    };
}

- (FTGDateRule *(^)(NSDate *anotherValue))after {
    return ^(NSDate *anotherValue){
        [self setValidation:^BOOL(NSDate *value) {
            return [value compare:anotherValue] == NSOrderedDescending;
        }];
        return self;
    };
}

- (FTGDateRule *(^)(NSDate *anotherValue))before {
    return ^(NSDate *anotherValue){
        [self setValidation:^BOOL(NSDate *value) {
            return [value compare:anotherValue] == NSOrderedAscending;
        }];
        return self;
    };
}

- (FTGDateRule *(^)(NSDate *dat1, NSDate *dat2))between {
    return ^(NSDate *dat1, NSDate *dat2){
        [self setValidation:^BOOL(NSDate *value) {
            return [value compare:dat1] == NSOrderedDescending && [value compare:dat2] == NSOrderedAscending;
        }];
        return self;
    };
}

@end
