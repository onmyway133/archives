//
//  ViewController.m
//  DotReactiveCocoaDemo
//
//  Created by Khoa Pham on 4/11/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "ViewController.h"
#import "RACSignal+FTGDot.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()

@property (nonatomic, copy) NSString *username;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RACObserve(self, username)
    .ftg_filter(^(NSString *newName){
        return [newName hasPrefix:@"j"];
    })
    .ftg_subscribeNext(^(NSString *newName){
        NSLog(@"%@", newName);
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
