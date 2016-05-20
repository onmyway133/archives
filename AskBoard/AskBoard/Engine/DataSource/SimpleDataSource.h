//
//  SimpleDataSource.h
//  AskBoard
//
//  Created by Khoa Pham on 5/5/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SimpleDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) void (^cellConfigureBlock)(id cell, id model);
@property (nonatomic, copy) NSString *cellIdentifier;

@end
