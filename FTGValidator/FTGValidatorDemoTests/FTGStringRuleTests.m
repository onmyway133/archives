//
//  FTGStringRuleTests.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FTGValidator.h"

@interface FTGStringRuleTests : XCTestCase

@end

@implementation FTGStringRuleTests

- (void)testRuleNotEmpty {
    NSString *value = @"Fantageek";

    NSString *message = @"Value must not be empty";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).notEmpty.with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleEqual {
    NSString *value = @"Fantageek";
    NSString *value2 = @"Fantageek";

    NSString *message = @"Values must be the same";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).to.equalTo(value2).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleMin {
    NSString *value = @"Fantageek";

    NSString *message = @"Value should have min 2 characters";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).min(2).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleMax {
    NSString *value = @"Fantageek";

    NSString *message = @"Value should have max 10 characters";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).max(10).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleLength {
    NSString *value = @"Fantageek";

    NSString *message = @"Value must have 9 characters";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).length(9).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleRange {
    NSString *value = @"Fantageek";

    NSString *message = @"Value must have 2 to 10 characters";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).range(2, 10).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleMatchRegExWithPattern {
    NSString *value = @"90001";

    NSString *message = @"Value must be US zip code format";
    NSString *pattern = @"^[0-9][0-9][0-9][0-9][0-9]$";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).to.matchRegExWithPattern(pattern).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleContain {
    NSString *value = @"Fantageek is awesome";

    NSString *message = @"Value must contains Fantageek";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).to.contain(@"Fantageek").with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleIn {
    NSString *value = @"Fantageek";
    NSArray *array = @[@"Fantageek", @"Google", @"Apple"];

    NSString *message = @"Value must be in the array";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).in(array).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}

- (void)testRuleCustomBlock {
    NSString *value = @"onmyway133@gmail.com";

    NSString *message = @"Value must of email format";

    BOOL (^customBlock)(NSString *value) = ^(NSString *value){
        BOOL stricterFilter = NO;
        NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
        NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
        NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:value];
    };

    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).to.satisfyBlock(customBlock).with.message(message),
                                                                 ]];

    XCTAssertTrue([validator validate].succeeded, @"");
    XCTAssertTrue([validator validate].message == nil, @"");
}


@end
