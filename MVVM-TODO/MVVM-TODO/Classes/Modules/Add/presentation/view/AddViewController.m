//
//  AddViewController.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AddViewController.h"
#import "AddViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface AddViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *minimumDate;

@end

@implementation AddViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.minimumDate = [NSDate date];
    [self bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(dismiss)];
    [self.transitioningBackgroundView addGestureRecognizer:gestureRecognizer];
    self.transitioningBackgroundView.userInteractionEnabled = YES;

    [self.nameTextField becomeFirstResponder];

    self.datePicker.minimumDate = self.minimumDate;
}

#pragma mark - Action
- (IBAction)save:(id)sender {
    [self.viewModel addWithName:self.nameTextField.text
                        dueDate:self.datePicker.date];
}


- (IBAction)cancel:(id)sender {
    [self.viewModel cancel];
}

- (void)dismiss {
    [self.viewModel cancel];
}

#pragma mark - Binding {
- (void)bindViewModel {
    @weakify(self);
    [RACObserve(self.viewModel, invalidMessage) subscribeNext:^(NSString *message) {
        @strongify(self);
        [self showAlertWithMessage:message];
    }];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];

    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    return YES;
}

@end
