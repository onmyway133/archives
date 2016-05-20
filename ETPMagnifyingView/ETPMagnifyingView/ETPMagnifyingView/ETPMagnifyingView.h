//
//  ETPMagnifyingView.h
//  ETPMagnifyingView
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETPMagnifyingView : UIView

/*!
 * @discussion The scrollView inside. Use this to setup scrollView
 */
@property (nonatomic, strong) UIScrollView *scrollView;

/*!
 * @discussion Edge here means that not in the middle. Middle subViews has scale 1. EdgeScale ranges from 0 to 1. Set this for edge subViews
 */
@property (nonatomic, assign) CGFloat edgeScale;

/*!
 * @discussion Used to receive any UIScrollViewDelegate methods
 */
@property (nonatomic, weak) id<UIScrollViewDelegate> scrollViewDelegate;

@end
