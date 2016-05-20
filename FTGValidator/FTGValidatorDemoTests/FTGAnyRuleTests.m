//
//  FTGAnyRuleTests.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FTGValidator.h"

@interface FTGAnyRuleTests : XCTestCase

@end

@implementation FTGAnyRuleTests

- (void)testAnyRule {
    NSString *message = @"Array must have 3 elements";

    NSArray *value = @[@"one", @"two", @"three"];
    BOOL (^customBlock)(NSArray *) = ^(NSArray *array) {
        if (array.count == 3) {
            return YES;
        }

        return NO;
    };

    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_ANY(value).to.satisfyBlock(customBlock).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

@end
