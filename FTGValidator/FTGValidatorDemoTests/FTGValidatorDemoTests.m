//
//  FTGValidatorDemoTests.m
//  FTGValidatorDemoTests
//
//  Created by Khoa Pham on 2/7/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FTGValidator.h"

// Expose
@interface FTGValidator (Test)

@property (nonatomic, strong) NSArray *rules;

@end


@interface FTGValidatorDemoTests : XCTestCase
@end

@implementation FTGValidatorDemoTests

- (void)testValidatorCreation {
    NSString *value = @"Fantageek";

    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(value).length(20),
                                                                 REQUIRE_STRING(value).to.contain(@"F"),
                                                                 ]];

    XCTAssertTrue(validator.rules.count == 2, @"Should have enough rules after creation");
}



@end
