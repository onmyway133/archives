//
//  FTGStringRule.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGStringRule.h"

@implementation FTGStringRule

- (FTGStringRule *)notEmpty {
    [self setValidation:^BOOL(NSString *value) {
        return value.length > 0;
    }];
    return self;
}

- (FTGStringRule * (^)(NSString *anotherValue))equalTo {
    return ^(NSString *anotherValue){
        [self setValidation:^BOOL(NSString *value) {
            return [value isEqualToString:anotherValue];
        }];
        return self;
    };
}

- (FTGStringRule * (^)(NSInteger min))min {
    return ^(NSInteger min){
        [self setValidation:^BOOL(NSString *value) {
            return value.length >= min;
        }];
        return self;
    };
}

- (FTGStringRule * (^)(NSInteger max))max {
    return ^(NSInteger max){
        [self setValidation:^BOOL(NSString *value) {
            return value.length <= max;
        }];
        return self;
    };
}

- (FTGStringRule * (^)(NSInteger length))length {
    return ^(NSInteger length){
        [self setValidation:^BOOL(NSString *value) {
            return value.length == length;
        }];
        return self;
    };
}

- (FTGStringRule * (^)(NSInteger min, NSInteger max))range {
    return ^(NSInteger min, NSInteger max){
        [self setValidation:^BOOL(NSString *value) {
            return value.length >= min && value.length <= max;
        }];
        return self;
    };
}


- (FTGStringRule * (^)(NSRegularExpression *regEx))matchRegEx {
    return ^(NSRegularExpression *regEx){
        [self setValidation:^BOOL(NSString *value) {
            NSUInteger matches = [regEx numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)];
            return matches == 1;
        }];
        return self;
    };
}

- (FTGStringRule * (^)(NSString *pattern))matchRegExWithPattern {
    return ^(NSString *pattern){
        NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        self.matchRegEx(regEx);
        return self;
    };
}

- (FTGStringRule * (^)(NSString *subString))contain {
    return ^(NSString *subString){
        [self setValidation:^BOOL(NSString *value) {
            return [value rangeOfString:subString].location != NSNotFound;
        }];
        return self;
    };
}

- (FTGStringRule * (^)(NSArray *array))in {
    return ^(NSArray *array){
        [self setValidation:^BOOL(NSString *value) {
            return [array containsObject:value];
        }];
        return self;
    };
}

@end
