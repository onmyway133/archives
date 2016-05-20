//
//  QuestionsViewModel.m
//  AskBoard
//
//  Created by Khoa Pham on 5/5/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "QuestionsViewModel.h"
#import "Question.h"
#import <Firebase/Firebase.h>
#import <MTLModel+MEDAdditions.h>
#import "MTLModel+Additions.h"
#import "Configuration.h"

@interface QuestionsViewModel ()

@property (nonatomic, strong, readwrite) NSMutableArray *questions;
@property (nonatomic, strong) RACSubject *dataChangedSubject;
@property (nonatomic, strong) Firebase *fireBase;

@end

@implementation QuestionsViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupFireBase];
    }

    return self;
}

#pragma mark - Firebase
- (void)setupFireBase {
    self.fireBase = [[Firebase alloc] initWithUrl:kFireBaseURLString];

    [self.fireBase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        Question *question = [Question med_modelFromJSONDictionary:snapshot.value];
        question.fireBaseKey = snapshot.key;
        if (question) {
            [self.questions insertObject:question atIndex:0];
            [self.dataChangedSubject sendNext:self.questions];
        }
    }];

    [self.fireBase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self.dataChangedSubject sendNext:self.questions];
    }];
}

#pragma mark - Data
- (NSMutableArray *)questions {
    if (!_questions) {
        _questions = [NSMutableArray array];
    }

    return _questions;
}

#pragma mark - RAC
- (RACSubject *)dataChangedSubject {
    if (!_dataChangedSubject) {
        _dataChangedSubject = [RACSubject subject];
    }

    return _dataChangedSubject;
}
- (RACSignal *)dataChangedSignal {
    return self.dataChangedSubject;
}

- (void)postQuestion:(Question *)question {
    NSDictionary *dict = [question ftg_toDictionary];
    [[self.fireBase childByAutoId] setValue:dict];
}


@end
