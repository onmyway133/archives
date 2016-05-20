//
//  UIStoryboard+FTGAdditions.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "UIStoryboard+FTGAdditions.h"

@implementation UIStoryboard (FTGAdditions)

+ (UIStoryboard *)ftg_mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

@end
