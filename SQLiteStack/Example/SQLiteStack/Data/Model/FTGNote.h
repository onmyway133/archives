//
//  FTGNote.h
//  SQLiteStack
//
//  Created by Khoa Pham on 12/7/15.
//  Copyright © 2015 Khoa Pham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTGSQLiteSerializing.h"

@interface FTGNote : NSObject <FTGSQLiteSerializing>

@property (nonatomic, copy) NSString *modelID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic) NSTimeInterval timeInterval;

@end
