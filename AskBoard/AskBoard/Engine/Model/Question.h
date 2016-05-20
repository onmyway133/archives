//
//  Question.h
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Mantle.h>

@class User;

@interface Question : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) User *user;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *fireBaseKey;

@end
