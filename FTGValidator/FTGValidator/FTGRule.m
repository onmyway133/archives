//
//  FTGRule.m
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/7/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGRule.h"

@implementation FTGRule

#pragma mark - Validate
- (BOOL)validate {
    NSAssert(self.validationBlock, @"Set validation block by explicitly tell what constraint is required");

    return self.validationBlock(self.value);
}

- (void)setValidation:(FTGValidationBlock)block {
    self.validationBlock = block;
}

#pragma mark - Type Checking
- (void)checkType {

}

#pragma mark - Builder
- (instancetype)with {
    return self;
}

- (instancetype)to {
    return self;
}

- (FTGRule * (^)(NSString *message))message {
    return ^(NSString *string){
        self.validationMessage = string;
        return self;
    };
}

- (FTGRule * (^)(FTGValidationBlock))satisfyBlock {
    return ^(BOOL (^block)(id value)){
        [self setValidation:^BOOL(id value) {
            return block(value);
        }];
        return self;
    };
}

@end
