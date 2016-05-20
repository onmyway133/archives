//
//  FTGSnippet.h
//  FriendlySnippets
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTGSnippet : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *completionShortcut;
@property (nonatomic, copy) NSArray *completionScopes;
@property (nonatomic, copy) NSString *content;

@end
