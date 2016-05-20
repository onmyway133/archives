//
//  AddWireframe.h
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AddViewModel;
@class VTDCoreDataStore;

@interface AddWireframe : NSObject

- (void)showAddModuleFromViewController:(UIViewController *)viewController
                              viewModel:(AddViewModel *)viewModel
                              dataStore:(VTDCoreDataStore *)dataStore;
- (void)dismissAddModule;

@end
