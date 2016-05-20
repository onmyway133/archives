//
//  FTGCircularTuner.h
//  CircularTunerDemo
//
//  Created by Khoa Pham on 4/11/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTGCircularTuner : UIControl

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) NSInteger lineCount;
@property (nonatomic, strong) UIColor *completeColor;
@property (nonatomic, strong) UIColor *incompleteColor;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BOOL flipped;


@end
