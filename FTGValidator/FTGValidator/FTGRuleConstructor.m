//
//  FTGRuleConstructor.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGRuleConstructor.h"
#import "FTGStringRule.h"
#import "FTGNumberRule.h"
#import "FTGDateRule.h"
#import "FTGAnyRule.h"

FTGStringRule * REQUIRE_STRING(NSString *value) {
    FTGStringRule *rule = [[FTGStringRule alloc] init];
    rule.value = value;
    
    return rule;
}

FTGNumberRule * REQUIRE_NUMBER(NSNumber *value) {
    FTGNumberRule *rule = [[FTGNumberRule alloc] init];
    rule.value = value;

    return rule;
}

FTGDateRule * REQUIRE_DATE(NSDate *value) {
    FTGDateRule *rule = [[FTGDateRule alloc] init];
    rule.value = value;

    return rule;
}

FTGAnyRule * REQUIRE_ANY(id value) {
    FTGAnyRule *rule = [[FTGAnyRule alloc] init];
    rule.value = value;

    return rule;
}

