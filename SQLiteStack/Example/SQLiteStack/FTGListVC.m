//
//  FTGListVC.m
//  SQLiteStack
//
//  Created by Khoa Pham on 12/7/15.
//  Copyright © 2015 Khoa Pham. All rights reserved.
//

#import "FTGListVC.h"
#import "FTGDataManager.h"
#import "FTGDetailVC.h"

@interface FTGListVC ()

@property (nonatomic) FTGDataManager *dataManager;
@property (nonatomic) NSMutableArray *notes;
@property (nonatomic) NSDateFormatter *dateFormatter;

@end


@implementation FTGListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataManager = [[FTGDataManager alloc] init];
    [self.dataManager setup];

    self.dateFormatter = [[NSDateFormatter alloc] init];

    self.notes = [NSMutableArray arrayWithArray:[self.dataManager loadNotes]];

    __weak FTGListVC *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification
                                                      object:[UIApplication sharedApplication]
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification * _Nonnull note)
    {
        [weakSelf.dataManager saveNotes:self.notes];
    }];
}

#pragma mark - Action
- (IBAction)addButtonTouch:(UIBarButtonItem *)sender {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notes"
                                                                   message:@"Add a new note"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Content goes here";
    }];

    __weak FTGListVC *weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action)
    {
        UITextField *textField = alert.textFields.firstObject;
        [weakSelf createNoteWithContent:textField.text];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Data
- (void)createNoteWithContent:(NSString *)content {
    FTGNote *note = [self.dataManager createNoteWithContent:content];

    [self.notes insertObject:note atIndex:0];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    FTGNote *note = self.notes[indexPath.row];

    cell.textLabel.text = note.content;

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:note.timeInterval];
    cell.detailTextLabel.text = [self.dateFormatter stringFromDate:date];

    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Seque
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    FTGDetailVC *detailVC = (id)segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

    FTGNote *note = self.notes[indexPath.row];
    [detailVC updateWithNote:note];
}

@end
