//
//  FTGClassB+FTGAdditions.h
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/27/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGClassB.h"

@class FTGClassA;

@interface FTGClassB (FTGAdditions)

@property (nonatomic, weak) FTGClassA *categoryWeakProperty;
@property (nonatomic, strong) NSString *categoryCanBeNilProperty;

@end
