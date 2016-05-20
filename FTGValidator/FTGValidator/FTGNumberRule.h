//
//  FTGNumberRule.h
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGRule.h"

@interface FTGNumberRule : FTGRule

- (FTGNumberRule * (^)(NSNumber *anotherValue))equalTo;
- (FTGNumberRule * (^)(NSNumber *anotherValue))greaterThan;
- (FTGNumberRule * (^)(NSNumber *anotherValue))lessThan;
- (FTGNumberRule * (^)(NSNumber *number1, NSNumber *number2))between;

@end
