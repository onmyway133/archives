//
//  FTGStringRule.h
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGRule.h"

@interface FTGStringRule : FTGRule

- (FTGStringRule *)notEmpty;
- (FTGStringRule * (^)(NSString *anotherValue))equalTo;
- (FTGStringRule * (^)(NSInteger min))min;
- (FTGStringRule * (^)(NSInteger max))max;
- (FTGStringRule * (^)(NSInteger length))length;
- (FTGStringRule * (^)(NSInteger min, NSInteger max))range;
- (FTGStringRule * (^)(NSRegularExpression *regEx))matchRegEx;
- (FTGStringRule * (^)(NSString *pattern))matchRegExWithPattern;
- (FTGStringRule * (^)(NSString *subString))contain;
- (FTGStringRule * (^)(NSArray *array))in;

@end
