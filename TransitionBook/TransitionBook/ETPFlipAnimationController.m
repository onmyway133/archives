//
//  ETPFlipAnimationController.m
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ETPFlipAnimationController.h"
#import "UIView+Additions.h"

@implementation ETPFlipAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Query transitionContext
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];

    // Add toVC view to containerView
    [containerView addSubview:toVC.view];

    // Perspective transform
    CATransform3D perspectiveTransform3D = CATransform3DIdentity;
    perspectiveTransform3D.m34 = -0.002;
    [containerView.layer setSublayerTransform:perspectiveTransform3D];

    // Set initial frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromVC.view.frame = initialFrame;
    toVC.view.frame = initialFrame;

    // Create snapshots
    // The order is important
    NSArray *toViewSnapshots = [toVC.view  createSnapshotsOf2SidesAfterScreenUpdates:YES];
    //[containerView sendSubviewToBack:toVC.view];
    [containerView addSubview:toViewSnapshots[0]];
    [containerView addSubview:toViewSnapshots[1]];
    UIView *flippedSideToView = toViewSnapshots[self.isPushOperation ? 0 : 1];


    NSArray *fromViewSnapshots = [fromVC.view createSnapshotsOf2SidesAfterScreenUpdates:NO];
    //[containerView sendSubviewToBack:fromVC.view];
    [containerView addSubview:fromViewSnapshots[0]];
    [containerView addSubview:fromViewSnapshots[1]];
    UIView *flippedSideFromView = fromViewSnapshots[self.isPushOperation ? 1 : 0];


    // Update anchorPoint
    [flippedSideFromView updateAnchorPointAndOffset:CGPointMake(self.isPushOperation ? 0 : 1, 0.5)];
    [flippedSideToView updateAnchorPointAndOffset:CGPointMake(self.isPushOperation ? 1 : 0, 0.5)];

    // Initial rotation to hide flippedSideToView
    flippedSideToView.layer.transform = CATransform3DMakeRotation(self.isPushOperation ? M_PI_2 : -M_PI_2, 0, 1, 0);

    // Animation
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateKeyframesWithDuration:duration
                                   delay:0
                                 options:0
                              animations:^{

                                  // Rotate flippedSideFromView to 90 degree
                                  [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
                                      flippedSideFromView.layer.transform = CATransform3DMakeRotation(self.isPushOperation ? -M_PI_2 : M_PI_2, 0, 1, 0);
                                  }];

                                  // Rotate flippedSideToView to 0 degree
                                  [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                                      flippedSideToView.layer.transform = CATransform3DMakeRotation(self.isPushOperation ? 0 : -0, 0, 1, 0);
                                  }];
                              }
                              completion:^(BOOL finished){
                                  if ([transitionContext transitionWasCancelled]) {
                                      [containerView removeAllSubviewsExceptSubview:fromVC.view];
                                  } else {
                                      [containerView removeAllSubviewsExceptSubview:toVC.view];
                                  }

                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                              }];
}

@end
