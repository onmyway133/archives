//
//  ListViewModel.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "ListViewModel.h"
#import "AddWireframe.h"
#import "ListInteractorProtocol.h"
#import "VTDUpcomingDisplayDataCollector.h"
#import "VTDUpcomingDisplayData.h"
#import "AddViewModel.h"

@implementation ListViewModel

- (void)fetchData {
    [self.interactor fetchUpcomingItemsWithCompletion:^(NSArray *items) {
        self.data = [self upcomingDisplayDataWithItems:items];
    }];
}

- (void)showAddModuleFromViewController:(id)viewController {
    AddWireframe *addWireframe = [AddWireframe new];
    AddViewModel *addViewModel = [AddViewModel new];
    [addWireframe showAddModuleFromViewController:viewController
                                        viewModel:addViewModel
                                        dataStore:[self.interactor dataStore]];
}

#pragma mark - Boundary
- (VTDUpcomingDisplayData *)upcomingDisplayDataWithItems:(NSArray *)upcomingItems {
    VTDUpcomingDisplayDataCollector *collector = [[VTDUpcomingDisplayDataCollector alloc] init];
    [collector addUpcomingItems:upcomingItems];

    return [collector collectedDisplayData];
}

@end
