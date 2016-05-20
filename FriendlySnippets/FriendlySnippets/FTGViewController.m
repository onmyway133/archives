//
//  FTGViewController.m
//  FriendlySnippets
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGViewController.h"
#import "FTGSnippetManager.h"

@interface FTGViewController ()

@end

@implementation FTGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    FTGSnippetManager *snippetManager = [[FTGSnippetManager alloc] init];
    [snippetManager performParsing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
