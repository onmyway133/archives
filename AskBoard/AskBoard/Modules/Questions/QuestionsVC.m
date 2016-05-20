//
//  QuestionsVC.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "QuestionsVC.h"
#import "AddQuestionVC.h"
#import <UIViewController+MEDAdditions.h>
#import "UserManager.h"
#import "User.h"
#import <ReactiveCocoa.h>
#import "Question.h"
#import <Masonry.h>
#import "QuestionsViewModel.h"
#import "SimpleDataSource.h"
#import "AnswersVC.h"
#import <SVProgressHUD.h>

@interface QuestionsVC () <UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) QuestionsViewModel *viewModel;
@property (nonatomic, strong) SimpleDataSource *dataSource;

@end

@implementation QuestionsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    [self setupTableView];
}

#pragma mark - Setup
- (void)setupNavigationItems {
    self.title = [UserManager sharedManager].user.username;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addButtonTouched:)];
}

- (void)setupTableView {
    self.dataSource = [SimpleDataSource new];
    self.dataSource.cellIdentifier = @"Cell";
    self.dataSource.cellConfigureBlock = ^(UITableViewCell *cell, Question *question) {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = question.content;
        cell.detailTextLabel.text = question.user.username;
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
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];

    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - Action
- (void)addButtonTouched:(id)sender {
    AddQuestionVC *addQuestionVC = [AddQuestionVC med_instantiateFromStoryboardNamed:@"Question"];

    @weakify(self);
    [[addQuestionVC addQuestionSignal] subscribeNext:^(Question *question) {
        @strongify(self);
        [self.viewModel postQuestion:question];

    }];

    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:addQuestionVC];
    [self presentViewController:navC animated:YES completion:nil];
}


#pragma mark - ViewModel
- (QuestionsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [QuestionsViewModel new];
    }

    return _viewModel;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Question *question = self.dataSource.items[indexPath.row];

    AnswersVC *anwersVC = [AnswersVC med_instantiateFromStoryboardNamed:@"Answer"];
    anwersVC.question = question;

    [self.navigationController pushViewController:anwersVC animated:YES];
}

@end
