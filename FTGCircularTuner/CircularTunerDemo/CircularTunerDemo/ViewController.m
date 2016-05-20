//
//  ViewController.m
//  CircularTunerDemo
//
//  Created by Khoa Pham on 4/11/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "ViewController.h"
#import "FTGCircularTuner.h"

@interface ViewController ()

@property (nonatomic, strong) FTGCircularTuner *tuner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FTGCircularTuner *tuner = [[FTGCircularTuner alloc] init];
    tuner.incompleteColor = [UIColor grayColor];
    tuner.image = [UIImage imageNamed:@"volume"];

    [tuner addTarget:self action:@selector(tunerDidBeginInteraction:) forControlEvents:UIControlEventEditingDidBegin];
    [tuner addTarget:self action:@selector(tunerDidEndInteraction:) forControlEvents:UIControlEventEditingDidEnd];
    [tuner addTarget:self action:@selector(tunerProgressChanged:) forControlEvents:UIControlEventValueChanged];

    self.tuner = tuner;
    [self.view addSubview:tuner];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.tuner.frame = CGRectMake(0, 0, 200, 250);
    self.tuner.center = self.view.center;
}

#pragma mark - Event
- (void)tunerDidBeginInteraction:(id)sender {
    NSLog(@"begin");
}

- (void)tunerDidEndInteraction:(id)sender {
    NSLog(@"end");
}

- (void)tunerProgressChanged:(FTGCircularTuner *)tuner {
    NSLog(@"progress %f", tuner.progress);
}



@end
