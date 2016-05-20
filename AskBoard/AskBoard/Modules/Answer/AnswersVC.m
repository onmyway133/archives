//
//  QuestionActivityVC.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AnswersVC.h"
#import "Question.h"
#import "User.h"
#import "SimpleDataSource.h"
#import <ReactiveCocoa.h>
#import "AnswersViewModel.h"
#import "Answer.h"
#import <PSTAlertController.h>
#import "UserManager.h"
#import <SVProgressHUD.h>

@interface AnswersVC ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UILabel *askerLabel;

@property (nonatomic, strong) SimpleDataSource *dataSource;
@property (nonatomic, strong) AnswersViewModel *viewModel;

@end

@implementation AnswersVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.textView.layer.borderWidth = 1.0;

    [self displayQuestion];
    [self setupNavigationItems];
    [self setupTableView];
}

#pragma mark - Setup
- (void)displayQuestion {
    self.askerLabel.text = self.question.user.username;
    self.textView.text = self.question.content;
}

- (void)setupTableView {
    self.dataSource = [SimpleDataSource new];
    self.dataSource.cellIdentifier = @"Cell";
    self.dataSource.cellConfigureBlock = ^(UITableViewCell *cell, Answer *answer) {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = answer.content;
        cell.detailTextLabel.text = answer.user.username;
    };

    @weakify(self);
    [SVProgressHUD show];
    [[self.viewModel dataChangedSignal] subscribeNext:^(NSArray *items) {
        @strongify(self);
        self.dataSource.items = items;
        [self.tableView reloadData];

        [SVProgressHUD dismiss];
    }];

    self.tableView.dataSource = self.dataSource;
    self.tableView.tableFooterView = [UIView new];

    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Setup
- (void)setupNavigationItems {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Answer"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(addButtonTouched:)];
}

#pragma mark - Action
- (void)addButtonTouched:(id)sender {
    PSTAlertController *controller = [PSTAlertController alertWithTitle:@"Answer" message:@"Input your answer here"];
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Answer goes here";
    }];

    [controller addAction:[PSTAlertAction actionWithTitle:@"Post" handler:^(PSTAlertAction *action) {
        UITextField *textField = controller.textField;
        [self postAnswerWithContent:textField.text];
    }]];

    [controller addCancelActionWithHandler:nil];

    [controller showWithSender:sender controller:self animated:YES completion:nil];
}

- (void)postAnswerWithContent:(NSString *)content {
    if (content.length == 0) {
        return;
    }

    Answer *anwer = [[Answer alloc] init];
    anwer.content = content;
    anwer.user = [UserManager sharedManager].user;

    [self.viewModel postAnswer:anwer];
}

#pragma mark - ViewModel
- (AnswersViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AnswersViewModel alloc] initWithQuestion:self.question];
    }

    return _viewModel;
}

@end
