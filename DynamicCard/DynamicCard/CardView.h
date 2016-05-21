//
//  CardView.h
//  DynamicCard
//
//  Created by Khoa Pham on 2/27/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic, copy) NSString *title;

@property (strong, nonatomic) UIPushBehavior *pushBehavior;
@property (strong, nonatomic) UISnapBehavior *snapBehavior;

@end
