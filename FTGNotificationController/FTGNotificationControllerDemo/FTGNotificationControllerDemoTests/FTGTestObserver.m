//
//  FTGTestObserver.m
//  FTGNotificationControllerDemo
//
//  Created by Khoa Pham on 6/21/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGTestObserver.h"

@implementation FTGTestObserver

- (void)handleNotification:(NSNotification *)note
{
    NSLog(@"handleNotification %@", note);
}

@end
