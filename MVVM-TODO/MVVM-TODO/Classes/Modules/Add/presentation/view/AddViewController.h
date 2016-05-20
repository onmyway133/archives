//
//  AddViewController.h
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddViewModel;

@interface AddViewController : UIViewController

// Prefer constructor injection than property injection
@property (nonatomic, strong) AddViewModel *viewModel;

@property (nonatomic, strong) UIView *transitioningBackgroundView;

@end
