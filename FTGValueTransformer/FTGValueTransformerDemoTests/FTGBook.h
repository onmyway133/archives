//
//  FTGBook.h
//  FTGValueTransformerDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface FTGBook : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *price;

@end
