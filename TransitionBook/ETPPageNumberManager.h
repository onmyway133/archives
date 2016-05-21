//
//  ETPPageNumberManager.h
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETPPageNumberManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign, readonly) NSUInteger pageNumber;

- (BOOL)isMaxPage;
- (void)increase;
- (void)decrease;

@end
