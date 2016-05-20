//
//  LoginVC.m
//  AskBoard
//
//  Created by Khoa Pham on 5/4/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "LoginVC.h"
#import <ReactiveCocoa.h>
#import "UserManager.h"

@interface LoginVC ()

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIButton *gotButton;

@property (nonatomic, strong) RACSubject *loginSubject;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self bind];
}

- (IBAction)buttonTouched:(id)sender {
    [[UserManager sharedManager] loginWithUsername:self.textField.text];
    [self.loginSubject sendCompleted];
}

#pragma mark - RAC
- (void)bind {
    RAC(self.gotButton, enabled) = [self.textField.rac_textSignal
                                    map:^id(NSString *string) {
                                        return string.length > 0 ? @(YES) : @(NO);
                                    }];
}

- (RACSubject *)loginSubject {
    if (!_loginSubject) {
        _loginSubject = [RACSubject subject];
    }

    return _loginSubject;
}

- (RACSignal *)loginDidFinishSignal {
    return self.loginSubject;
}

@end
