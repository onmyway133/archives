//
//  ETPFlipInteractionController.m
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ETPFlipInteractionController.h"
#import "ETPNormalPageViewController.h"
#import "ETPPageNumberManager.h"

@interface ETPFlipInteractionController ()

@property (strong, nonatomic) UINavigationController *wiredNavigationController;

@end


@implementation ETPFlipInteractionController

- (void)addGestureRecognizerToViewController:(UIViewController *)viewController
{
    UIScreenEdgePanGestureRecognizer *leftScreenEdgePanGestureRecognizer =
        [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleLeftScreenEdgePanGesture:)];
    leftScreenEdgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:leftScreenEdgePanGestureRecognizer];

    if (![[ETPPageNumberManager sharedInstance] isMaxPage]) {
        UIScreenEdgePanGestureRecognizer *rightScreenEdgePanGestureRecognizer =
        [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(handleRightScreenEdgePanGesture:)];
        rightScreenEdgePanGestureRecognizer.edges = UIRectEdgeRight;
        [viewController.view addGestureRecognizer:rightScreenEdgePanGestureRecognizer];
    }

    self.wiredNavigationController = viewController.navigationController;
}

- (void)handleLeftScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.isInteractive = YES;

        [[ETPPageNumberManager sharedInstance] decrease];

        [self.wiredNavigationController popViewControllerAnimated:YES];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // Ratio for Pop operation goes from 0..1
        CGFloat ratio = location.x / CGRectGetWidth(gestureRecognizer.view.bounds);
        [self updateInteractiveTransition:ratio];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (velocity.x > 0) {
            [self finishInteractiveTransition];
        } else {
            [[ETPPageNumberManager sharedInstance] increase];
            [self cancelInteractiveTransition];
        }

        self.isInteractive = NO;
    }
}

- (void)handleRightScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];

    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.isInteractive = YES;

        [[ETPPageNumberManager sharedInstance] increase];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        ETPNormalPageViewController *normalPageVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"NormalPageViewController"];
        [self.wiredNavigationController pushViewController:normalPageVC animated:YES];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        // Ratio for Push operation goes from 1..0
        // ratio should always go from 0..1
        CGFloat ratio = location.x / CGRectGetWidth(gestureRecognizer.view.bounds);
        ratio = 1 - ratio;
        [self updateInteractiveTransition:ratio];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (velocity.x < 0) {
            [self finishInteractiveTransition];
        } else {
            [[ETPPageNumberManager sharedInstance] decrease];
            [self cancelInteractiveTransition];
        }

        self.isInteractive = NO;
    }
}

@end
