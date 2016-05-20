//
//  Answer.h
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Mantle.h>

@class User;

@interface Answer : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *content;

@end
