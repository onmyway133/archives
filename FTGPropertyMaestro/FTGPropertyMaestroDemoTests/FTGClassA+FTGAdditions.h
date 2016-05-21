//
//  FTGClassA+FTGAdditions.h
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/27/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGClassA.h"

@interface FTGClassA (FTGAdditions)

@property (nonatomic, assign, getter = fetchCategoryBoolProperty) BOOL categoryBoolProperty;
@property (nonatomic, strong) NSNumber *categoryStrongProperty;
@property (nonatomic, copy, setter = updateCategoryCopyProperty:) NSString *categoryCopyProperty;

@end
