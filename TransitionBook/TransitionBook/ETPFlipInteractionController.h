//
//  ETPFlipInteractionController.h
//  TransitionBook
//
//  Created by Khoa Pham on 3/3/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETPFlipInteractionController : UIPercentDrivenInteractiveTransition


@property (assign, nonatomic) BOOL isInteractive;

- (void)addGestureRecognizerToViewController:(UIViewController *)viewController;

@end
