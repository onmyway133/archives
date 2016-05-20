//
//  AddWireframe.m
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "AddWireframe.h"
#import "AddViewController.h"
#import "AddInteractorProtocol.h"
#import "AddInteractor.h"
#import "AddViewModel.h"
#import "UIStoryboard+FTGAdditions.h"
#import "VTDAddPresentationTransition.h"
#import "VTDAddDismissalTransition.h"
#import "VTDAddDataManager.h"

static NSString *AddViewControllerIdentifier = @"AddViewController";

@interface AddWireframe () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIViewController *sourceViewController;

@end

@implementation AddWireframe

- (void)showAddModuleFromViewController:(UIViewController *)viewController
                              viewModel:(AddViewModel *)viewModel
                              dataStore:(VTDCoreDataStore *)dataStore {
    self.sourceViewController = viewController;

    // Instantiate
    AddViewController *view = [self makeAddViewController];

    VTDAddDataManager *manager = [VTDAddDataManager new];
    manager.dataStore = dataStore;
    id<AddInteractorProtocol> interactor = [[AddInteractor alloc] initWithManager:manager];

    // Wire
    view.viewModel = viewModel;

    viewModel.interactor = interactor;
    viewModel.wireframe = self;

    // Animation
    view.modalPresentationStyle = UIModalPresentationCustom;
    view.transitioningDelegate = self;

    // Show
    [viewController presentViewController:view animated:YES completion:nil];
}

- (void)dismissAddModule {
    [self.sourceViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper
- (AddViewController *)makeAddViewController {
    return [[UIStoryboard ftg_mainStoryboard] instantiateViewControllerWithIdentifier:AddViewControllerIdentifier];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[VTDAddDismissalTransition alloc] init];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [[VTDAddPresentationTransition alloc] init];
}


@end
