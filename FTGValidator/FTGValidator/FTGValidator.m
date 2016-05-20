//
//  FTGValidator.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/7/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGValidator.h"

@interface FTGValidator ()

@property (nonatomic, strong) NSArray *rules;

@end

@implementation FTGValidator

+ (instancetype)validatorWithRules:(NSArray *)rules {
    FTGValidator *validator = [[FTGValidator alloc] init];
    validator.rules = rules;
    
    return validator;
}

- (FTGValidationResult *)validate {
    FTGRule *rule = [self findFirstRuleThatValidateFailed];
    
    FTGValidationResult *result = [[FTGValidationResult alloc] init];
    result.succeeded = rule ? NO : YES;
    result.message = result.succeeded ? nil : rule.validationMessage;

    return result;
}


#pragma mark - Helper
- (FTGRule *)findFirstRuleThatValidateFailed {
    for (FTGRule *rule in self.rules) {
        if (![rule validate]) {
            return rule;
        }
    }

    return nil;
}

@end
