//
//  ETPNormalPageViewController.m
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ETPNormalPageViewController.h"
#import "ETPPageNumberManager.h"
#import "ColorManager.h"


@interface ETPNormalPageViewController () <UINavigationControllerDelegate>

@end

@implementation ETPNormalPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSUInteger pageNumber = [[ETPPageNumberManager sharedInstance] pageNumber];
    self.title = [NSString stringWithFormat:@"Page %d", pageNumber];

    self.view.backgroundColor = [ColorManager colorAtIndex:pageNumber];

    self.pageNumberLabel.text = [NSString stringWithFormat:@"This is page No. %d", pageNumber];

    if ([[ETPPageNumberManager sharedInstance] isMaxPage]) {
        self.nextButton.hidden = YES;
    }

    NSLog(@"viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)nextButtonAction:(id)sender
{
    [[ETPPageNumberManager sharedInstance] increase];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    ETPNormalPageViewController *normalPageVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"NormalPageViewController"];

    [self.navigationController pushViewController:normalPageVC animated:YES];

}

- (IBAction)previousButtonAction:(id)sender
{
    [[ETPPageNumberManager sharedInstance] decrease];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate

@end
