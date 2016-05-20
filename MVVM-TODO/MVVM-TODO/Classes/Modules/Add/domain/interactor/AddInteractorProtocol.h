//
//  AddInteractorProtocol.h
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddInteractorProtocol <NSObject>

- (void)addToDoWithName:(NSString *)name dueDate:(NSDate *)date;

@end
