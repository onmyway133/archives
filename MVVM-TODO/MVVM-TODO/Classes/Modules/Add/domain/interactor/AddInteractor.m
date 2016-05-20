//
//  AddInteractor.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AddInteractor.h"
#import "VTDAddDataManager.h"
#import "VTDTodoItem.h"

@interface AddInteractor ()

@property (nonatomic, strong) VTDAddDataManager *manager;

@end

@implementation AddInteractor

- (instancetype)initWithManager:(VTDAddDataManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;
    }

    return self;
}

- (void)addToDoWithName:(NSString *)name dueDate:(NSDate *)date {
    VTDTodoItem *toDo = [[VTDTodoItem alloc] init];
    toDo.name = name;
    toDo.dueDate = date;

    [self.manager addNewEntry:toDo];
}

@end
