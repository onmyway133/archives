//
//  CardView.m
//  DynamicCard
//
//  Created by Khoa Pham on 2/27/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "CardView.h"

@interface CardView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, frame.size.width, 20)];
        [self addSubview:_titleLabel];

        self.alpha = 0.8;
        self.layer.cornerRadius = 10;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}


@end
