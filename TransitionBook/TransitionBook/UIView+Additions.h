//
//  UIView+Additions.h
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

- (NSArray *)createSnapshotsOf2SidesAfterScreenUpdates:(BOOL)afterUpdates;
- (void)updateAnchorPointAndOffset:(CGPoint)anchorPoint;
- (void)removeAllSubviewsExceptSubview:(UIView *)subview;

@end
