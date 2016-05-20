//
//  FTGSQLiteStack.h
//  Pods
//
//  Created by Khoa Pham on 12/7/15.
//
//

#import <Foundation/Foundation.h>
#import "FTGSQLiteSerializing.h"

@interface FTGSQLiteStack : NSObject

- (instancetype)init;
- (instancetype)initWithStoreName:(NSString *)storeName;
- (instancetype)initWithPath:(NSString *)path;

- (void)createTables:(NSArray<NSString *> *)modelClassNames;
- (NSArray<NSObject<FTGSQLiteSerializing> *> *)loadAllWithModelClass:(Class)modelClass;
- (void)executeStatement:(NSString *)statement;
- (void)executeStatements:(NSArray<NSString *> *)statements;

@end
