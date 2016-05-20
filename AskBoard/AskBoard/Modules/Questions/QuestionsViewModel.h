//
//  QuestionsViewModel.h
//  AskBoard
//
//  Created by Khoa Pham on 5/5/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@class Question;

@interface QuestionsViewModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *questions;

- (RACSignal *)dataChangedSignal;
- (void)postQuestion:(Question *)question;

@end
