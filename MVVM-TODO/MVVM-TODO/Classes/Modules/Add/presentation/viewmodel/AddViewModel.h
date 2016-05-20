//
//  AddViewModel.h
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddInteractorProtocol;
@class AddWireframe;

@interface AddViewModel : NSObject

@property (nonatomic, strong) id<AddInteractorProtocol> interactor;
@property (nonatomic, strong) AddWireframe *wireframe;

@property (nonatomic, strong) NSString *invalidMessage;

- (void)addWithName:(NSString *)name dueDate:(NSDate *)date;
- (void)cancel;

@end
