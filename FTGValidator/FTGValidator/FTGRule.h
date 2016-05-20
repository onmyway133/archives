//
//  FTGRule.h
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/7/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL (^FTGValidationBlock)(id value);

@interface FTGRule : NSObject

@property (nonatomic, strong) id value;
@property (nonatomic, copy) NSString *validationMessage;
@property (nonatomic, copy) FTGValidationBlock validationBlock;

#pragma mark - Validate
- (BOOL)validate;
- (void)setValidation:(FTGValidationBlock)block;

#pragma mark - Builder
- (instancetype)with;
- (instancetype)to;
- (FTGRule * (^)(NSString *message))message;

/**
 *  Make sure the block argument is of the same type as the Rule 's value
 */
- (FTGRule * (^)(FTGValidationBlock))satisfyBlock;

@end
