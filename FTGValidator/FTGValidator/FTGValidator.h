//
//  FTGValidator.h
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/7/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTGValidationResult.h"
#import "FTGRule.h"
#import "FTGRuleConstructor.h"
#import "FTGStringRule.h"
#import "FTGNumberRule.h"
#import "FTGDateRule.h"
#import "FTGAnyRule.h"

@interface FTGValidator : NSObject

+ (instancetype)validatorWithRules:(NSArray *)rules;

- (FTGValidationResult *)validate;

@end
