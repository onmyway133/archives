//
//  FTGRuleConstructor.h
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTGStringRule;
@class FTGNumberRule;
@class FTGDateRule;
@class FTGAnyRule;

FTGStringRule * REQUIRE_STRING(NSString *value);
FTGNumberRule * REQUIRE_NUMBER(NSNumber *value);
FTGDateRule * REQUIRE_DATE(NSDate *value);
FTGAnyRule * REQUIRE_ANY(id value);