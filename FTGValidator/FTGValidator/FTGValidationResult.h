//
//  FTGValidationResult.h
//  FTGValidatorDemo
//
//  Created by Khoa Pham on 2/8/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTGValidationResult : NSObject

@property (nonatomic, assign) BOOL succeeded;
@property (nonatomic, copy) NSString *message;

@end
