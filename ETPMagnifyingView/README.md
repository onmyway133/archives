ETPMagnifyingView
==
Custom UIView that supports magnifying paging UIScrollView

![ETPMagnifyingView](http://i59.tinypic.com/rbjl7k.png)

How it works
--
 - Place a small UIScrollView inside a custom view. Any subviews added to this UIScrollView needs to be the same size as the UIScrollView, in order to get the paging work
 - The container custom view has clipsToBounds = YES and override hitTest:withEvent: to return the UIScrollView
 - I use HTDelegateProxy to achieve multicast delegate

How to use it
--
 - Typical usage
``` 
(void)setupMagnifyingView
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

    // This is important
    self.magnifyingView.edgeScale = 0.6;
    self.magnifyingView.scrollViewDelegate = self;
}
```
 - More customization
```
self.magnifyingView.scrollView.pagingEnabled = NO;
self.magnifyingView.scrollView.showsHorizontalScrollIndicator = YES;
```

License
--
This project is released under the MIT license. See LICENSE.md.

Reference
--
1. [Paging UIScrollView in increments smaller than frame size](http://stackoverflow.com/questions/1677085/paging-uiscrollview-in-increments-smaller-than-frame-size)
2. [UIScrollView horizontal paging like Mobile Safari tabs](http://stackoverflow.com/questions/1220354/uiscrollview-horizontal-paging-like-mobile-safari-tabs)
3. [HTDelegateProxy](https://github.com/hoteltonight/HTDelegateProxy)
4. [A MULTICAST DELEGATE PATTERN FOR IOS CONTROLS](http://www.scottlogic.com/blog/2012/11/19/a-multicast-delegate-pattern-for-ios-controls.html)