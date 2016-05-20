//
//  AnswersViewModel.h
//  AskBoard
//
//  Created by Khoa Pham on 5/5/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@class Answer;
@class Question;

@interface AnswersViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *answers;

- (instancetype)initWithQuestion:(Question *)question;
- (RACSignal *)dataChangedSignal;
- (void)postAnswer:(Answer *)answer;

@end
