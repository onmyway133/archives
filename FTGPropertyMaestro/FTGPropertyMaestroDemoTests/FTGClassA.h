//
//  FTGClassA.h
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/27/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTGClassA : NSObject

@property (nonatomic, assign) BOOL boolProperty;
@property (nonatomic, strong) NSNumber *strongProperty;

// prefix "ftg" to avoid "property's synthesized getter follows Cocoa naming convention for returning 'owned' objects" error
@property (nonatomic, copy) NSString *ftgCopyProperty;

@end
