//
//  User.h
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Mantle.h>

@interface User : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *username;

@end
