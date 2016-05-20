//
//  FTGValidationResultTests.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FTGValidator.h"

@interface FTGValidationResultTests : XCTestCase

@end

@implementation FTGValidationResultTests

- (void)testFailedResult {
    NSString *value = nil;

    NSString *message = @"Value must not be empty";
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).notEmpty.with.message(message),
                                                                 ]];

    FTGValidationResult *result = [validator validate];

    XCTAssertTrue(result, @"");
    XCTAssertTrue(result.succeeded == NO, @"");
    XCTAssertTrue([result.message isEqualToString:message], @"");
}

@end
