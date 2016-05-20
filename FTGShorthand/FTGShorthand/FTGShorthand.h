//
//  FTGShorthand.h
//  FTGShorthandDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTGShorthand : NSObject

+ (void)setPrefix:(NSString *)prefix;

+ (void)supportShorthandMethodsForClass:(Class)kClass;
+ (void)supportShorthandMethodsForClasses:(NSArray *)classes;

@end
