//
//  FTGPopup.m
//  FTGPopupDemo
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGPopup.h"
#import "FTGPopupWindow.h"
#import "FTGPopupViewController.h"

@interface FTGPopup ()

@property (nonatomic, strong) FTGPopupWindow *window;
@property (nonatomic, strong) FTGPopupViewController *viewController;

@end

@implementation FTGPopup

+ (instancetype)sharedInstance
{
    static FTGPopup *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

- (FTGPopupWindow *)window
{
    NSAssert([NSThread isMainThread], @"You must use %@ from the main thread only.", NSStringFromClass([self class]));

    if (!_window) {
        _window = [[FTGPopupWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

        _window.rootViewController = self.viewController;
    }

    return _window;
}

- (FTGPopupViewController *)viewController
{
    if (!_viewController) {
        _viewController = [[FTGPopupViewController alloc] init];
    }

    return _viewController;
}

#pragma mark - Public Interface
+ (void)showView:(UIView *)view withSize:(CGSize)size
{
    FTGPopup *sharedInstance = [self sharedInstance];

    [sharedInstance.viewController showView:view withSize:size];
    sharedInstance.window.hidden = NO;
}

+ (void)close
{
    FTGPopup *sharedInstance = [self sharedInstance];

    [sharedInstance.viewController close];
    sharedInstance.window.hidden = YES;
}

@end
