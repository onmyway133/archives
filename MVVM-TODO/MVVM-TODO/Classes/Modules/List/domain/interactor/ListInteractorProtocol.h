//
//  ListInteractorProtocol.h
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VTDCoreDataStore;

@protocol ListInteractorProtocol <NSObject>

- (void)fetchUpcomingItemsWithCompletion:(void (^)(NSArray *items))completion;
- (VTDCoreDataStore *)dataStore;

@end
