//
//  ListWireframe.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "ListWireframe.h"
#import "UIStoryboard+FTGAdditions.h"
#import "ListViewController.h"
#import "ListInteractorProtocol.h"
#import "ListInteractor.h"
#import "ListViewModel.h"
#import "VTDDeviceClock.h"
#import "VTDListDataManager.h"
#import "VTDCoreDataStore.h"

static NSString *ListViewControllerIdentifier = @"ListViewController";

@interface ListWireframe ()

@end

@implementation ListWireframe

- (void)showListModuleInNavigation:(UINavigationController *)navigationController {
    // Instantiate
    ListViewController *view = [self makeListViewController];

    VTDListDataManager *manager = [VTDListDataManager new];
    manager.dataStore = [[VTDCoreDataStore alloc] init];
    id<VTDClock> clock = [VTDDeviceClock new];
    id<ListInteractorProtocol> interactor = [[ListInteractor alloc] initWithManager:manager clock:clock];
    
    ListViewModel *viewModel = [ListViewModel new];

    // Wire
    view.viewModel = viewModel;

    viewModel.interactor = interactor;
    viewModel.wireframe = self;

    // Show
    navigationController.viewControllers = @[view];
}

#pragma mark - Helper
- (ListViewController *)makeListViewController {
    return [[UIStoryboard ftg_mainStoryboard] instantiateViewControllerWithIdentifier:ListViewControllerIdentifier];
}

@end
