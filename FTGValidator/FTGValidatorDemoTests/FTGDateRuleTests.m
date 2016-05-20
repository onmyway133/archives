//
//  FTGDateRuleTests.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FTGValidator.h"

@interface FTGDateRuleTests : XCTestCase

@end

@implementation FTGDateRuleTests

- (void)testRuleEqual {
    NSDate *value = [NSDate dateWithTimeIntervalSince1970:10];
    NSDate *value2 = [NSDate dateWithTimeIntervalSince1970:10];

    NSString *message = @"Values must be the same";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_DATE(value).to.equalTo(value2).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleAfter {
    NSDate *value = [NSDate dateWithTimeIntervalSince1970:10];

    NSString *message = @"Value should be later than 1/1/1970 00:00:02";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_DATE(value).after([NSDate dateWithTimeIntervalSince1970:2]).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleBefore {
    NSDate *value = [NSDate dateWithTimeIntervalSince1970:10];

    NSString *message = @"Value should be earlier than 1/1/1970 00:01:00";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_DATE(value).before([NSDate dateWithTimeIntervalSince1970:60]).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}


- (void)testRuleBetween {
    NSDate *value = [NSDate dateWithTimeIntervalSince1970:10];

    NSString *message = @"Value must be between 1/1/1970 00:00:02 and 1/1/1970 00:01:00";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_DATE(value).between([NSDate dateWithTimeIntervalSince1970:2], [NSDate dateWithTimeIntervalSince1970:60]).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

@end
