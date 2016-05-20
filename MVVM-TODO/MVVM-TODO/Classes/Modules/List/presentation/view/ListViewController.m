//
//  ListViewController.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "ListViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ListViewModel.h"

#import "VTDUpcomingDisplayData.h"
#import "VTDUpcomingDisplaySection.h"
#import "VTDUpcomingDisplayItem.h"

static NSString* const VTDListEntryCellIdentifier = @"VTDListEntryCell";

@interface ListViewController ()

@property (nonatomic, strong) IBOutlet UIView *noContentView;
@property (nonatomic, strong) UITableView *strongTableView;

@end


@implementation ListViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.strongTableView = self.tableView;
    [self configureView];
    [self showNoContentView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.viewModel fetchData];
}

- (void)configureView {
    self.navigationItem.title = @"TODO";

    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addButtonTouched:)];
    self.navigationItem.rightBarButtonItem = addItem;
}


#pragma mark - Binding
- (void)setViewModel:(ListViewModel *)viewModel {
    _viewModel = viewModel;

    [self bindViewModel];
}
- (void)bindViewModel {
    [[RACObserve(self.viewModel, data)
      map:^id(VTDUpcomingDisplayData *data) {
        return @(data.sections.count > 0);
    }]
     subscribeNext:^(NSNumber *hasData) {
        if ([hasData boolValue]) {
            [self showTableView];
        } else {
            [self showNoContentView];
        }
    }];
}

#pragma mark - Action
- (void)addButtonTouched:(id)sender {
    [self.viewModel showAddModuleFromViewController:self];
}

#pragma mark - Show
- (void)showNoContentView {
    self.view = self.noContentView;
}

- (void)showTableView {
    self.view = self.strongTableView;
    [self.strongTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel.data.sections count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    VTDUpcomingDisplaySection *upcomingSection = self.viewModel.data.sections[section];

    return [upcomingSection.items count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    VTDUpcomingDisplaySection *upcomingSection = self.viewModel.data.sections[section];

    return upcomingSection.name;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VTDUpcomingDisplaySection *section = self.viewModel.data.sections[indexPath.section];
    VTDUpcomingDisplayItem *item = section.items[indexPath.row];

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:VTDListEntryCellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.dueDay;
    cell.imageView.image = [UIImage imageNamed:section.imageName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

@end
