//
//  AnswersViewModel.m
//  AskBoard
//
//  Created by Khoa Pham on 5/5/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AnswersViewModel.h"
#import "Answer.h"
#import <Firebase/Firebase.h>
#import <MTLModel+MEDAdditions.h>
#import "MTLModel+Additions.h"
#import "Configuration.h"
#import "Question.h"

@interface AnswersViewModel ()

@property (nonatomic, strong) RACSubject *dataChangedSubject;
@property (nonatomic, strong) Firebase *fireBase;
@property (nonatomic, strong) Question *question;

@end

@implementation AnswersViewModel

- (instancetype)initWithQuestion:(Question *)question {
    self = [super init];
    if (self) {
        _question = question;
        [self setupFireBase];
    }

    return self;
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

- (void)postAnswer:(Answer *)answer {
    NSDictionary *dict = [answer ftg_toDictionary];
    [[self.fireBase childByAutoId] setValue:dict];
}

#pragma mark - Firebase
- (void)setupFireBase {
    self.fireBase = [[[[Firebase alloc] initWithUrl:kFireBaseURLString]
                      childByAppendingPath:self.question.fireBaseKey]
                     childByAppendingPath:@"answers"];

    [self.fireBase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        Answer *answer = [Answer med_modelFromJSONDictionary:snapshot.value];
        if (answer) {
            [self.answers insertObject:answer atIndex:0];
            [self.dataChangedSubject sendNext:self.answers];
        }
    }];

    [self.fireBase observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self.dataChangedSubject sendNext:self.answers];
    }];
}

#pragma mark - Data
- (NSMutableArray *)answers {
    if (!_answers) {
        _answers = [NSMutableArray array];
    }

    return _answers;
}

@end
