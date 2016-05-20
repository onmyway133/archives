//
//  FTGPopupWindow.m
//  FTGPopupDemo
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGPopupWindow.h"

@implementation FTGPopupWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Some apps have windows at UIWindowLevelStatusBar + n.
        // If we make the window level too high, we block out UIAlertViews.
        // There's a balance between staying above the app's windows and staying below alerts.
        // UIWindowLevelStatusBar + 100 seems to hit that balance.
        self.windowLevel = UIWindowLevelStatusBar + 100.0;
    }
    return self;
}

@end
