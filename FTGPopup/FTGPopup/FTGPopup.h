//
//  FTGPopup.h
//  FTGPopupDemo
//
//  Created by Khoa Pham on 9/2/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTGPopup : NSObject

+ (void)showView:(UIView *)view withSize:(CGSize)size;
+ (void)close;

@end
