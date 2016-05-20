//
//  FTGPopupViewController.m
//  FTGPopupDemo
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGPopupViewController.h"

@interface FTGPopupViewController ()

@property (nonatomic, strong) UIView *userView;
@property (nonatomic, assign) CGSize userViewSize;

@end

@implementation FTGPopupViewController

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

    self.view.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Logic
- (void)showView:(UIView *)view withSize:(CGSize)size
{
    // Close existing userView if any
    [self close];

    self.userView = view;
    self.userViewSize = size;

    [self.view addSubview:self.userView];
    [self setupConstraintsForUserView];
}

- (void)close
{
    if (self.userView) {
        [self.userView removeFromSuperview];
    }
}

- (void)setupConstraintsForUserView
{
    self.userView.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.userView
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:0];

    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.userView
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:0];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.userView
                                                                         attribute:NSLayoutAttributeWidth
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.0
                                                                          constant:self.userViewSize.width];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.userView
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:self.userViewSize.height];

    [self.view addConstraints:@[ centerXConstraint, centerYConstraint, widthConstraint, heightConstraint ]];

    [self.view setNeedsUpdateConstraints];
}

#pragma mark - Orientation and StatusBar Apperance

// Try to get the preferred status bar properties from the app's root view controller (not us).
// In general, our window shouldn't be the key window when this view controller is asked about the status bar.
// However, we guard against infinite recursion and provide a reasonable default for status bar behavior in case our window is the keyWindow.

- (UIViewController *)viewControllerForStatusBarAndOrientationProperties
{
    UIViewController *viewControllerToAsk = [[[UIApplication sharedApplication] keyWindow] rootViewController];

    // On iPhone, modal view controllers get asked
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        while (viewControllerToAsk.presentedViewController) {
            viewControllerToAsk = viewControllerToAsk.presentedViewController;
        }
    }

    return viewControllerToAsk;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController *viewControllerToAsk = [self viewControllerForStatusBarAndOrientationProperties];
    UIStatusBarStyle preferredStyle = UIStatusBarStyleDefault;
    if (viewControllerToAsk && viewControllerToAsk != self) {
        // We might need to foward to a child
        UIViewController *childViewControllerToAsk = [viewControllerToAsk childViewControllerForStatusBarStyle];
        if (childViewControllerToAsk) {
            preferredStyle = [childViewControllerToAsk preferredStatusBarStyle];
        } else {
            preferredStyle = [viewControllerToAsk preferredStatusBarStyle];
        }
    }
    return preferredStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    UIViewController *viewControllerToAsk = [self viewControllerForStatusBarAndOrientationProperties];
    UIStatusBarAnimation preferredAnimation = UIStatusBarAnimationFade;
    if (viewControllerToAsk && viewControllerToAsk != self) {
        preferredAnimation = [viewControllerToAsk preferredStatusBarUpdateAnimation];
    }
    return preferredAnimation;
}

- (BOOL)prefersStatusBarHidden
{
    UIViewController *viewControllerToAsk = [self viewControllerForStatusBarAndOrientationProperties];
    BOOL prefersHidden = NO;
    if (viewControllerToAsk && viewControllerToAsk != self) {
        // Again, we might need to forward to a child
        UIViewController *childViewControllerToAsk = [viewControllerToAsk childViewControllerForStatusBarHidden];
        if (childViewControllerToAsk) {
            prefersHidden = [childViewControllerToAsk prefersStatusBarHidden];
        } else {
            prefersHidden = [viewControllerToAsk prefersStatusBarHidden];
        }
    }
    return prefersHidden;
}


#pragma mark - Rotation

- (NSUInteger)supportedInterfaceOrientations
{
    UIViewController *viewControllerToAsk = [self viewControllerForStatusBarAndOrientationProperties];
    NSUInteger supportedOrientations = [self infoPlistSupportedInterfaceOrientationsMask];
    if (viewControllerToAsk && viewControllerToAsk != self) {
        supportedOrientations = [viewControllerToAsk supportedInterfaceOrientations];
    }

    // The UIViewController docs state that this method must not return zero.
    // If we weren't able to get a valid value for the supported interface orientations, default to all supported.
    if (supportedOrientations == 0) {
        supportedOrientations = UIInterfaceOrientationMaskAll;
    }

    return supportedOrientations;
}

- (BOOL)shouldAutorotate
{
    UIViewController *viewControllerToAsk = [self viewControllerForStatusBarAndOrientationProperties];
    BOOL shouldAutorotate = YES;
    if (viewControllerToAsk && viewControllerToAsk != self) {
        shouldAutorotate = [viewControllerToAsk shouldAutorotate];
    }
    return shouldAutorotate;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

#pragma mark - Plist
- (UIInterfaceOrientationMask)infoPlistSupportedInterfaceOrientationsMask
{
    NSArray *supportedOrientations = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"UISupportedInterfaceOrientations"];
    UIInterfaceOrientationMask supportedOrientationsMask = 0;
    if ([supportedOrientations containsObject:@"UIInterfaceOrientationPortrait"]) {
        supportedOrientationsMask |= UIInterfaceOrientationMaskPortrait;
    }
    if ([supportedOrientations containsObject:@"UIInterfaceOrientationMaskLandscapeRight"]) {
        supportedOrientationsMask |= UIInterfaceOrientationMaskLandscapeRight;
    }
    if ([supportedOrientations containsObject:@"UIInterfaceOrientationMaskPortraitUpsideDown"]) {
        supportedOrientationsMask |= UIInterfaceOrientationMaskPortraitUpsideDown;
    }
    if ([supportedOrientations containsObject:@"UIInterfaceOrientationLandscapeLeft"]) {
        supportedOrientationsMask |= UIInterfaceOrientationMaskLandscapeLeft;
    }
    return supportedOrientationsMask;
}

@end
