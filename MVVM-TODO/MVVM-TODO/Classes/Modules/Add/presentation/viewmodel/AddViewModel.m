//
//  AddViewModel.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AddViewModel.h"
#import "AddInteractorProtocol.h"
#import "AddWireframe.h"

@implementation AddViewModel

- (void)addWithName:(NSString *)name dueDate:(NSDate *)date {
    if (name.length == 0) {
        self.invalidMessage = @"Name should not be empty";
        return;
    }
    
    [self.interactor addToDoWithName:name dueDate:date];
    [self.wireframe dismissAddModule];
}

- (void)cancel {
    [self.wireframe dismissAddModule];
}

@end
