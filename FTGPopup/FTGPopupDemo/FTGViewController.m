//
//  FTGViewController.m
//  FTGPopupDemo
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGViewController.h"
#import "FTGPopup.h"

@interface FTGViewController ()

@end

@implementation FTGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)showButtonAction:(id)sender
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];

    [FTGPopup showView:view withSize:CGSizeMake(200, 150)];
}

@end
