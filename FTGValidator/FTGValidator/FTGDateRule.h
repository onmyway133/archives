//
//  FTGDateRule.h
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGRule.h"

@interface FTGDateRule : FTGRule

- (FTGDateRule * (^)(NSDate *anotherValue))equalTo;
- (FTGDateRule * (^)(NSDate *anotherValue))after;
- (FTGDateRule * (^)(NSDate *anotherValue))before;
- (FTGDateRule * (^)(NSDate *date1, NSDate *date2))between;

@end
