//
//  FTGSQLiteSerializing.h
//  Pods
//
//  Created by Khoa Pham on 12/7/15.
//
//

#import <Foundation/Foundation.h>

@protocol FTGSQLiteSerializing <NSObject>

/**
 *  Only serialize these propery keys
 */
+ (NSArray<NSString *> *)propertyKeys;

/**
 *  This will be the primary key
 */
- (NSString *)modelID;

@end
