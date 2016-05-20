//
//  ETPViewController.m
//  ETPMagnifyingView
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ETPViewController.h"
#import "ETPMagnifyingView.h"

#define NUMBER_OF_PAGES  10

@interface ETPViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet ETPMagnifyingView *magnifyingView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ETPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupMagnifyingView];
    [self setupPageControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupMagnifyingView
{
    self.magnifyingView.backgroundColor = [UIColor yellowColor];

    for (int i=0; i< NUMBER_OF_PAGES; ++i) {
        NSString *imageName = [NSString stringWithFormat:@"number%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.magnifyingView.scrollView.bounds];
        imageView.image = image;

        CGRect imageFrame = CGRectMake(self.magnifyingView.scrollView.bounds.size.width * i, 0,
                                       self.magnifyingView.scrollView.bounds.size.width, self.magnifyingView.scrollView.bounds.size.height);

        imageView.frame = imageFrame;
        
        [self.magnifyingView.scrollView addSubview:imageView];

    }

    self.magnifyingView.scrollView.contentSize = CGSizeMake(self.magnifyingView.scrollView.bounds.size.width * NUMBER_OF_PAGES,
                                                            self.magnifyingView.scrollView.bounds.size.height);

    self.magnifyingView.edgeScale = 0.6;
    self.magnifyingView.scrollViewDelegate = self;
}

- (void)setupPageControl
{
    self.pageControl.numberOfPages = NUMBER_OF_PAGES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.magnifyingView.scrollView.bounds.size.width;
    NSInteger page = floor((self.magnifyingView.scrollView.contentOffset.x -  pageWidth / 2) / pageWidth) + 1;

    self.pageControl.currentPage = page;
}

@end
