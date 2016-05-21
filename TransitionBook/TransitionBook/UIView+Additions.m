//
//  UIView+Additions.m
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (NSArray *)createSnapshotsOf2SidesAfterScreenUpdates:(BOOL)afterUpdates
{
    // Create snapshot of the left side
    CGRect leftSideRegion = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
    UIView *leftSideView = [self resizableSnapshotViewFromRect:leftSideRegion
                                            afterScreenUpdates:afterUpdates
                                                 withCapInsets:UIEdgeInsetsZero];
    leftSideView.frame = leftSideRegion;

    // Create snapshot of the right side
    CGRect rightSideRegion = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
    UIView *rightSideView = [self resizableSnapshotViewFromRect:rightSideRegion
                                             afterScreenUpdates:afterUpdates
                                                  withCapInsets:UIEdgeInsetsZero];
    rightSideView.frame = rightSideRegion;


    return @[leftSideView, rightSideView];
}

- (void)updateAnchorPointAndOffset:(CGPoint)anchorPoint
{
    self.layer.anchorPoint = anchorPoint;
    float xOffset = anchorPoint.x - 0.5;
    self.frame = CGRectOffset(self.frame, xOffset * self.frame.size.width, 0);
}

- (void)removeAllSubviewsExceptSubview:(UIView *)subview
{
    for (UIView *view in self.subviews) {
        if (view != subview) {
            [view removeFromSuperview];
        }
    }
}

@end
