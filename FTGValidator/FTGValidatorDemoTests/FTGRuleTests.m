//
//  FTGRuleTests.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FTGRule.h"
#import "FTGRuleConstructor.h"

@interface FTGRuleTests : XCTestCase

@end

@implementation FTGRuleTests

- (void)testWith {
    FTGRule *rule = (id)REQUIRE_STRING(@"Some value");
    FTGRule *maybeAnotherRule = rule.with;

    XCTAssertTrue(rule == maybeAnotherRule, @"");
}

- (void)testTo {
    FTGRule *rule = (id)REQUIRE_STRING(@"Some value");
    FTGRule *maybeAnotherRule = rule.to;

    XCTAssertTrue(rule == maybeAnotherRule, @"");
}

- (void)testMessage {
    FTGRule *rule = (id)REQUIRE_STRING(@"Some value");
    rule.with.message(@"Message");

    XCTAssertTrue([rule.validationMessage isEqualToString:@"Message"], @"");
}

@end
