//
//  FTGNumberRuleTests.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FTGValidator.h"

@interface FTGNumberRuleTests : XCTestCase

@end

@implementation FTGNumberRuleTests

- (void)testRuleEqual {
    NSNumber *value = @(100);
    NSNumber *value2 = @(100);

    NSString *message = @"Values must be the same";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_NUMBER(value).to.equalTo(value2).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleGreaterThan {
    NSNumber *value = @(100);

    NSString *message = @"Value should be greater than 10";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_NUMBER(value).greaterThan(@(10)).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleLessThan {
    NSNumber *value = @(100);

    NSString *message = @"Value should be less than 101";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_NUMBER(value).lessThan(@(101)).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}


- (void)testRuleBetween {
    NSNumber *value = @(100);

    NSString *message = @"Value must be between 10 and 101";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_NUMBER(value).between(@(10), @(101)).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

@end
