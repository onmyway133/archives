//
//  ETPMagnifyingView.m
//  ETPMagnifyingView
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ETPMagnifyingView.h"
#import "HTDelegateProxy.h"

@interface ETPMagnifyingView () <UIScrollViewDelegate>

@property (nonatomic, strong) HTDelegateProxy *delegateProxy;

@end


@implementation ETPMagnifyingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self baseInit];
    }

    return self;
}

- (void)baseInit
{
    [self addSubview:self.scrollView];
}

- (void)layoutSubviews
{
    self.scrollView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

#pragma mark - Public interface
- (void)setEdgeScale:(CGFloat)edgeScale
{
    _edgeScale = edgeScale;

    [self rescaleAllSubViews];
}

- (void)setScrollViewDelegate:(id<UIScrollViewDelegate>)scrollViewDelegate
{
    _scrollViewDelegate = scrollViewDelegate;

    self.delegateProxy = [[HTDelegateProxy alloc] initWithDelegates:@[ self, _scrollViewDelegate ]];
    self.scrollView.delegate = (id)self.delegateProxy;
}

#pragma mark - Hit testing
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self pointInside:point withEvent:event]) {
        return self.scrollView;
    }

    return nil;
}

#pragma mark - ScrollView
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.frame = [self defaultScrollViewFrame];

        _scrollView.delegate = self;
    }

    return _scrollView;
}

- (CGRect)defaultScrollViewFrame
{
    CGFloat scrollViewSize = CGRectGetHeight(self.bounds) / 2;
    return CGRectIntegral(CGRectMake(0, 0, scrollViewSize, scrollViewSize));
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.bounds.size.width;
    NSInteger page = floor((self.scrollView.contentOffset.x -  pageWidth / 2) / pageWidth) + 1;

    CGFloat offset = scrollView.contentOffset.x - page * pageWidth;
    NSInteger nextPage = offset > 0 ? page + 1 : page - 1;

    UIView *subView = [self subViewAtPage:page];
    UIView *nextSubView = [self subViewAtPage:nextPage];

    CGFloat factor = fabs(offset) / pageWidth;

    // View going to the edge gets its scale down to self.edgeScale
    CGFloat currentScale = 1 - factor * (1 - self.edgeScale);
    subView.transform = CGAffineTransformMakeScale(currentScale, currentScale);

    // View going to the middle gets its scale up to 1
    CGFloat nextScale = self.edgeScale + factor * (1 - self.edgeScale);
    nextSubView.transform = CGAffineTransformMakeScale(nextScale, nextScale);
}

#pragma mark - Helpers
- (UIView *)subViewAtPage:(NSInteger)page
{
    if (page >= 0 && page <[self.scrollView.subviews count]) {
        return [self.scrollView.subviews objectAtIndex:page];
    }

    return nil;
}

- (void)rescaleAllSubViews
{
    CGFloat pageWidth = self.scrollView.bounds.size.width;
    NSInteger page = floor((self.scrollView.contentOffset.x -  pageWidth/ 2) / pageWidth) + 1;

    for (int i=0; i< [self.scrollView.subviews count]; ++i) {
        UIView *subView = [self subViewAtPage:i];
        if (i != page) {
            subView.transform = CGAffineTransformMakeScale(self.edgeScale, self.edgeScale);
        }
    }
}

@end
