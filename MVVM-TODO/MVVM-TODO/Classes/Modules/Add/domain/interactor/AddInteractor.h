//
//  AddInteractor.h
//  MVVM-TODO
//
//  Created by Khoa Pham on 3/20/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddInteractorProtocol.h"

@class VTDAddDataManager;

@interface AddInteractor : NSObject <AddInteractorProtocol>

- (instancetype)initWithManager:(VTDAddDataManager *)manager;

@end
