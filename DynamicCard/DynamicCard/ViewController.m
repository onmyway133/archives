//
//  ViewController.m
//  DynamicCard
//
//  Created by Khoa Pham on 2/26/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ViewController.h"
#import "ColorManager.h"
#import "CardView.h"

#define RADIANS_TO_DEGREES(radians)     ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle)       ((angle) / 180.0 * M_PI)

static const NSInteger NumberOfCards = 8;

@interface ViewController () <UICollisionBehaviorDelegate, UIDynamicAnimatorDelegate>

@property (nonatomic, strong) NSMutableArray *cardViews;

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;

@property (nonatomic) CGPoint currentTouchPoint;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCardViews];
    [self setupAnimator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupCardViews
{
    self.cardViews = [@[] mutableCopy];
    for (int i=0; i<NumberOfCards; i++) {
        CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, 200, 140)];
        cardView.backgroundColor = [ColorManager colorAtIndex:i];
        cardView.title = [NSString stringWithFormat:@"This is card No. %d", i];

        [UIView animateWithDuration:0.5 delay:(i * 0.2) options:UIViewAnimationOptionCurveEaseIn animations:^{
            cardView.center = self.view.center;
            cardView.transform = CGAffineTransformMakeRotation(M_PI_4 / 5 * i);
        } completion:nil];

        [self.cardViews addObject:cardView];
        [self.view addSubview:cardView];
    }
}

#pragma mark - UIKit Dynamics setup

- (void)setupAnimator
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.animator.delegate = self;

    [self setupGravityBehavior];
    [self setupCollisionBehavior];
    [self setupDynamicItemBehavior];
}

- (void)setupGravityBehavior
{
    self.gravityBehavior = [[UIGravityBehavior alloc] init];

    [self.animator addBehavior:self.gravityBehavior];
}

- (void)setupCollisionBehavior
{
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.cardViews];
    self.collisionBehavior.collisionDelegate = self;
    self.collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;

    // Use a larger invisible boundary
    [self.collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(-500, -500, -500, -500)];

    [self.animator addBehavior:self.collisionBehavior];
}

- (void)setupDynamicItemBehavior
{
    UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.cardViews];
    dynamicItemBehavior.angularResistance = 5;
    dynamicItemBehavior.elasticity = 0;

    [self.animator addBehavior:dynamicItemBehavior];
}

#pragma mark - Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CardView* cardView = (CardView *)touch.view;

    if (![self.cardViews containsObject:cardView]) {
        return;
    }

    CGPoint touchPoint = [touch locationInView:self.view];
    self.currentTouchPoint = touchPoint;

    CGPoint touchPointInCardView = [touch locationInView:cardView];
    CGPoint centerPointInCardView = CGPointMake(CGRectGetMidX(cardView.bounds), CGRectGetMidY(cardView.bounds));
    UIOffset offset = UIOffsetMake(touchPointInCardView.x - centerPointInCardView.x, touchPointInCardView.y - centerPointInCardView.y);

    // Add attachment
    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:cardView offsetFromCenter:offset attachedToAnchor:touchPoint];
    self.attachmentBehavior.length = 1.0f;
    self.attachmentBehavior.damping = 0;
    self.attachmentBehavior.frequency = 0;
    [self.animator addBehavior:self.attachmentBehavior];

    // Add gravity
    [self.gravityBehavior addItem:cardView];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    self.currentTouchPoint = touchPoint;

    self.attachmentBehavior.anchorPoint = touchPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CardView* cardView = (CardView *)touch.view;

    if (![self.cardViews containsObject:cardView]) {
        return;
    }

    CGPoint touchPoint = [touch locationInView:self.view];

    // Add push
    cardView.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[cardView] mode:UIPushBehaviorModeInstantaneous];
    cardView.pushBehavior.pushDirection = CGVectorMake(touchPoint.x - self.currentTouchPoint.x, touchPoint.y - self.currentTouchPoint.y);
    [self.animator addBehavior:cardView.pushBehavior];

    // Remove attachment
    [self.animator removeBehavior:self.attachmentBehavior];
    self.attachmentBehavior = nil;
}

#pragma mark - UICollisionBehaviorDelegate

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    CardView *cardView = (CardView *)item;

    // Remove push and gravity
    [self.animator removeBehavior:cardView.pushBehavior];
    cardView.pushBehavior = nil;
    [self.gravityBehavior removeItem:cardView];

    // Move to back
    [self.view sendSubviewToBack:cardView];
    [self.cardViews removeObject:cardView];
    [self.cardViews insertObject:cardView atIndex:0];

    /*
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        cardView.center = self.view.center;
    } completion:nil];
     */

    cardView.snapBehavior = [[UISnapBehavior alloc] initWithItem:cardView snapToPoint:self.view.center];
    cardView.snapBehavior.damping = 1;
    // Add snap
    [self.animator addBehavior:cardView.snapBehavior];

    __weak ViewController *weakSelf = self;
    __weak CardView *weakCardView = cardView;
    cardView.snapBehavior.action = ^{
        if (weakCardView.center.x == weakSelf.view.center.x && weakCardView.center.y == weakSelf.view.center.y) {
            NSLog(@"snapBehavior center");

            // PROBLEM Removing snap causes view to oscillate
            // Remove snap
            //weakCardView.center = weakSelf.view.center;
            //[weakSelf.animator removeBehavior:weakCardView.snapBehavior];
            //weakCardView.snapBehavior = nil;
            //[self rotateCardViews];

            // TRICK
            [self.animator removeAllBehaviors];
            [weakSelf rotateCardViews];
            [self setupAnimator];
        }
    };
}

#pragma mark - UIDynamicAnimatorDelegate
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{

}

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator
{

}

#pragma mark - Helper
- (void)rotateCardViews
{
    for (int i=0; i<NumberOfCards; ++i) {
        CardView *cardView = [self.cardViews objectAtIndex:i];

        [UIView animateWithDuration:0.25 animations:^{
            cardView.transform = CGAffineTransformMakeRotation(M_PI_4 / 5 * i);
        } completion:^(BOOL finished){
            [self.animator updateItemUsingCurrentState:cardView];
        }];
    }
}

@end
