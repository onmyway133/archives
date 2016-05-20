//
//  ListInteractor.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "ListInteractor.h"
#import "VTDClock.h"
#import "VTDListDataManager.h"
#import "NSCalendar+CalendarAdditions.h"
#import "NSArray+HOM.h"
#import "VTDTodoItem.h"
#import "VTDUpcomingItem.h"

@interface ListInteractor ()

@property (nonatomic, strong) VTDListDataManager *manager;
@property (nonatomic, strong) id<VTDClock> clock;

@end

@implementation ListInteractor

- (instancetype)initWithManager:(VTDListDataManager *)manager clock:(id<VTDClock>)clock {
    self = [super init];
    if (self) {
        _manager = manager;
        _clock = clock;
    }

    return self;
}

- (void)fetchUpcomingItemsWithCompletion:(void (^)(NSArray *))completion {
    __weak typeof(self) wSelf = self;
    NSDate *today = [self.clock today];
    NSDate *endOfNextWeek = [[NSCalendar currentCalendar] dateForEndOfFollowingWeekWithDate:today];

    [self.manager todoItemsBetweenStartDate:today endDate:endOfNextWeek completionBlock:^(NSArray *todoItems) {
        NSArray *upcomingItems = [wSelf upcomingItemsFromToDoItems:todoItems];
        if (completion) {
            completion(upcomingItems);
        }
    }];
}

- (VTDCoreDataStore *)dataStore {
    return self.manager.dataStore;
}

#pragma mark - Boundary
- (NSArray *)upcomingItemsFromToDoItems:(NSArray *)todoItems {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];

    NSArray *validTodoItems = (todoItems != nil) ? todoItems : @[];

    return [validTodoItems arrayFromObjectsCollectedWithBlock:^id(VTDTodoItem *todoItem) {
        VTDNearTermDateRelation relation = [calendar nearTermRelationForDate:todoItem.dueDate relativeToToday:[self.clock today]];

        return [VTDUpcomingItem upcomingItemWithDateRelation:relation dueDate:todoItem.dueDate title:todoItem.name];
    }];
}

@end
