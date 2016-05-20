//
//  FTGViewController.m
//  FTGNotificationControllerDemo
//
//  Created by Khoa Pham on 6/19/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGViewController.h"
#import "FTGNotificationController.h"

@interface FTGViewController ()

@property (nonatomic, strong) FTGNotificationController *notificationController;

@end

@implementation FTGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.notificationController = [FTGNotificationController controllerWithObserver:self];

}

- (IBAction)observeMemoryWarningNotification:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];

    [self.notificationController observeNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil
                                                   queue:[NSOperationQueue mainQueue]
                                                   block:^(NSNotification *note, id observer)
    {
        NSLog(@"notification %@ observer %@", note, observer);
    }];

    [self.notificationController observeNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:application
                                                   queue:[NSOperationQueue mainQueue]
                                                   block:^(NSNotification *note, id observer)
     {
         NSLog(@"notification %@ observer %@", note, observer);
     }];

}
- (IBAction)unobserveMemoryWarningNotificationButtonAction:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];

    [self.notificationController unobserveNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:application];

}

- (IBAction)unobserverAllButtonAction:(id)sender
{
    [self.notificationController unobserveAll];

}

- (void)handleNotification:(id)note
{
    NSLog(@"");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
