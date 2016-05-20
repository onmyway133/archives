//
//  FTGViewController.m
//  FTGAppstoreVersionCheckerDemo
//
//  Created by Khoa Pham on 6/18/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGViewController.h"
#import "FTGAppstoreVersionChecker.h"

@interface FTGViewController ()

@property (nonatomic, strong) FTGAppstoreVersionChecker *checker;

@end

@implementation FTGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.checker = [FTGAppstoreVersionChecker checker];

    self.checker.appStoreID = @"698488137";
    self.checker.applicationBundleID = @"com.dbs.homeconnect";
    self.checker.currentApplicationVersion = @"1.2";

    [self.checker checkForNewVersionOnAppStoreWithNewerBlock:^(NSString *appstoreVersion) {
        NSLog(@"There is newer version %@ on Appstore. Check it out", appstoreVersion);
    } failure:^(NSError *error) {
        NSLog(@"Error %@", error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
