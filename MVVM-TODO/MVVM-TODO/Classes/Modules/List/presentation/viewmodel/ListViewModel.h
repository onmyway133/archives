//
//  ListViewModel.h
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ListInteractorProtocol;

@class VTDUpcomingDisplayData;
@class ListWireframe;

@interface ListViewModel : NSObject

@property (nonatomic, strong) id<ListInteractorProtocol> interactor;
@property (nonatomic, strong) ListWireframe *wireframe;

@property (nonatomic, strong) VTDUpcomingDisplayData *data;

- (void)fetchData;
- (void)showAddModuleFromViewController:(UIViewController *)viewController;

@end
