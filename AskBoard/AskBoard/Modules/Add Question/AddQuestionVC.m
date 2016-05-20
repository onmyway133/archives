//
//  AddQuestionVC.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AddQuestionVC.h"
#import "Question.h"
#import <SZTextView.h>
#import "UserManager.h"

@interface AddQuestionVC ()

@property (nonatomic, weak) IBOutlet SZTextView *textView;
@property (nonatomic, strong) RACSubject *addQuestionSubject;

@end

@implementation AddQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textView.placeholder = @"Your question goes here";

    [self setupNavigationItems];
    [self bind];
}

#pragma mark - Setup
- (void)setupNavigationItems {
    self.title = @"ADD QUESTION";

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelButtonTouched:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(doneButtonTouched:)];
}

#pragma mark - RAC
- (void)bind {
    RAC(self.navigationItem.rightBarButtonItem, enabled) = [self.textView.rac_textSignal map:^id(NSString *string) {
        return string.length > 10 ? @(YES) : @(NO);
    }];
}

- (RACSubject *)addQuestionSubject {
    if (!_addQuestionSubject) {
        _addQuestionSubject = [RACSubject subject];
    }

    return _addQuestionSubject;
}

- (RACSignal *)addQuestionSignal {
    return self.addQuestionSubject;
}

#pragma mark - Action
- (void)cancelButtonTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneButtonTouched:(id)sender {
    [self.addQuestionSubject sendNext:[self makeQuestion]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Question
- (Question *)makeQuestion {
    Question *question = [Question new];
    question.content = self.textView.text;
    question.user = [UserManager sharedManager].user;

    return question;
}

@end
