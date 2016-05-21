//
//  ETPCoverPageViewController.m
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ETPCoverPageViewController.h"
#import "ETPNormalPageViewController.h"
#import "ETPPageNumberManager.h"
#import "ETPFlipAnimationController.h"
#import "ETPFlipInteractionController.h"


@interface ETPCoverPageViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) ETPFlipAnimationController *flipAnimationController;
@property (strong, nonatomic) ETPFlipInteractionController *flipInteractionController;

@end

@implementation ETPCoverPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Cover";

    // This is the only one delegate of the UINavigationController
    self.navigationController.delegate = self;

    self.flipAnimationController = [[ETPFlipAnimationController alloc] init];
    self.flipInteractionController = [[ETPFlipInteractionController alloc] init];

    [self.flipInteractionController addGestureRecognizerToViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)beginButtonAction:(id)sender
{
    [[ETPPageNumberManager sharedInstance] increase];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    ETPNormalPageViewController *normalPageVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"NormalPageViewController"];

    [self.navigationController pushViewController:normalPageVC animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    [self.flipInteractionController addGestureRecognizerToViewController:toVC];

    self.flipAnimationController.isPushOperation = (operation == UINavigationControllerOperationPush);
    return self.flipAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    // Return nil if we 're not in interaction
    return self.flipInteractionController.isInteractive ? self.flipInteractionController : nil;
}


@end
