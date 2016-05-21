//
//  ColorManager.m
//  DynamicCard
//
//  Created by Khoa Pham on 2/26/14.
//  Copyright (c) 2014 Khoa Pham. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager

+ (UIColor *)colorAtIndex:(NSInteger)index
{

    NSArray *colors = @[ [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor],
                         [UIColor blueColor], [UIColor magentaColor], [UIColor purpleColor], [UIColor grayColor],
                         [UIColor brownColor], [UIColor blackColor], [UIColor cyanColor], [UIColor whiteColor] ];
    return [colors objectAtIndex:index];
}

@end
