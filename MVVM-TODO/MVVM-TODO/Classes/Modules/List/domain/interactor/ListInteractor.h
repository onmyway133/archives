//
//  ListInteractor.h
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListInteractorProtocol.h"

@protocol VTDClock;
@class VTDListDataManager;

@interface ListInteractor : NSObject <ListInteractorProtocol>

- (instancetype)initWithManager:(VTDListDataManager *)manager clock:(id<VTDClock>)clock;

@end
