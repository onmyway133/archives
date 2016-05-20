//
//  FTGUser.h
//  FTGValueTransformerDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@class FTGBook;

@interface FTGUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) FTGBook *favoriteBook;

@end
