//
//  FTGSQLiteHelper.h
//  Pods
//
//  Created by Khoa Pham on 12/7/15.
//
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "FTGSQLiteSerializing.h"

@interface FTGSQLiteHelper : NSObject

- (NSString *)createTableStatementForModelClass:(Class)modelClass;
- (NSString *)selectAllStatementForModelClass:(Class)modelClass;
- (NSString *)deleteStatementForModels:(NSArray<NSObject<FTGSQLiteSerializing> *> *)models modelClass:(Class)modelClass;
- (NSString *)insertOrUpdateStatementForModel:(NSObject<FTGSQLiteSerializing> *)model modelClass:(Class)modelClass;

- (void)updateModel:(NSObject<FTGSQLiteSerializing> *)model resultSet:(FMResultSet *)resultSet;

@end
