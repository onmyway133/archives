//
//  FTGCircularTuner.m
//  CircularTunerDemo
//
//  Created by Khoa Pham on 4/11/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "FTGCircularTuner.h"

@interface FTGCircularTuner ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *lines;

@end

@implementation FTGCircularTuner

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }

    return self;
}

- (void)baseInit {
    _progress = 1.0;
    _lineCount = 15;
    _completeColor = [UIColor orangeColor];
    _incompleteColor = [UIColor whiteColor];

    self.backgroundColor = [UIColor clearColor];
    [self setupGR];
}

#pragma mark - Layout
- (void)layoutSubviews {
    [super layoutSubviews];

    if (!self.imageView) {
        [self setupImageView];
    }

    if (!self.lines) {
        [self setupLines];
    }
}

#pragma mark - GR
- (void)setupGR {
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGR:)];
    [self addGestureRecognizer:tapGR];

    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGR:)];
    [self addGestureRecognizer:panGR];
}

- (void)handleGR:(UIGestureRecognizer *)gr {
    CGPoint location = [gr locationInView:self];

    self.progress = (self.bounds.size.height - location.y) / self.bounds.size.height;

    [self notifyStateChanged:gr.state];
}

#pragma mark - Event
- (void)notifyStateChanged:(UIGestureRecognizerState)state {
    switch (state) {
        case UIGestureRecognizerStateBegan:
            [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
            break;
        default:
            break;
    }
}

#pragma mark - Progress
- (void)setProgress:(CGFloat)progress {

    progress = MAX(0, progress);
    progress = MIN(progress, 1);

    _progress = progress;

    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self setNeedsDisplay];
}

#pragma mark - Image
- (void)setupImageView {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = self.image;
    self.imageView.layer.zPosition = 2;

    [self addSubview:self.imageView];

    CGFloat imageViewPositionX = self.flipped ? (self.bounds.size.width - self.bounds.size.width/4) : self.bounds.size.width/4;
    CGPoint imageViewPosition = CGPointMake(imageViewPositionX, self.bounds.size.height/2);
    CGFloat imageViewSize = self.bounds.size.height/4;
    self.imageView.frame = CGRectMake(0, 0, imageViewSize, imageViewSize);
    self.imageView.center = imageViewPosition;
}

#pragma mark - Lines
- (void)setupLines {
    NSMutableArray *lines = [NSMutableArray arrayWithCapacity:self.lineCount];

    for (int i=0; i<self.lineCount; ++i) {
        CAShapeLayer *line = [CAShapeLayer layer];

        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 2, self.bounds.size.width - self.bounds.size.width/3)];

        line.path = path.CGPath;
        line.bounds = CGPathGetBoundingBox(path.CGPath);

        line.lineWidth = 3;
        line.fillColor = [UIColor clearColor].CGColor;

        line.strokeStart = 0.87;
        line.strokeEnd = 1.0;

        line.anchorPoint = CGPointMake(0.5, 1);

        CGFloat linePositionX = self.flipped ? (self.bounds.size.width - self.bounds.size.width/4) : self.bounds.size.width/4;
        line.position = CGPointMake(linePositionX, self.bounds.size.height/2);

        CGFloat distance = M_PI / (self.lineCount-1) * i;
        if (self.flipped) {
            distance *= -1;
        }

        line.affineTransform = CGAffineTransformMakeRotation(distance);

        [self.layer addSublayer:line];
        [lines addObject:line];
    }

    self.lines = [NSArray arrayWithArray:lines];
}

#pragma mark - Draw
- (void)drawRect:(CGRect)rect {
    for (int i=0; i<self.lineCount; ++i) {
        CAShapeLayer *line = self.lines[i];

        CGFloat incomplete = 1.0 - self.progress;

        if (i >= incomplete * self.lineCount) {
            line.strokeColor = self.completeColor.CGColor;
        } else {
            line.strokeColor = self.incompleteColor.CGColor;
        }
    }
}

@end
