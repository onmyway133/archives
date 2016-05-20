//
//  ViewController.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/7/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "ViewController.h"
#import "FTGValidator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    BOOL (^customBlock)(NSArray *) = ^(NSArray *array) {
        if (array.count == 3) {
            return YES;
        }

        return NO;
    };
    
    FTGValidator *validator = [FTGValidator validatorWithRules:@[REQUIRE_STRING(@"John").notEmpty.with.message(@"Value must not be empty"),
                                                                 REQUIRE_STRING(@"90001").to.matchRegExWithPattern(@"^[0-9][0-9][0-9][0-9][0-9]$").with.message(@"Value must be US zip code format"),
                                                                 REQUIRE_NUMBER(@(1990)).greaterThan(@(1970)).with.message(@"Must be born after 1970"),
                                                                 REQUIRE_ANY(@[@"one", @"two", @"three"]).satisfyBlock(customBlock).with.message(@"Array must have 3 elements"),
                                                                 ]];

    FTGValidationResult *result = [validator validate];
    if (result.succeeded) {
        NSLog(@"All rules pass");
    } else {
        NSLog(@"Failed. Show message: %@", result.message);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
