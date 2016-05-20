//
//  FTGSQLiteStack.m
//  Pods
//
//  Created by Khoa Pham on 12/7/15.
//
//

#import "FTGSQLiteStack.h"
#import "FMDB.h"
#import "FTGSQLiteHelper.h"
#import "FTGSQLiteSerializing.h"
#import "ObjectiveSugar.h"

@interface FTGSQLiteStack ()

@property (nonatomic) FMDatabaseQueue *queue;

@end


@implementation FTGSQLiteStack

#pragma mark - Init
- (instancetype)init {
    return [self initWithStoreName:@"sqlite"];
}

- (instancetype)initWithStoreName:(NSString *)storeName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths.firstObject stringByAppendingPathComponent:storeName];

    return [self initWithPath:path];
}

- (instancetype)initWithPath:(NSString *)path {
    self = [super init];

    self.queue = [FMDatabaseQueue databaseQueueWithPath:path];

    return self;
}

#pragma mark - Public
- (void)createTables:(NSArray<NSString *> *)modelClassNames {
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {

        FTGSQLiteHelper *helper = [FTGSQLiteHelper new];

        [modelClassNames each:^(NSString *modelClassName) {
            Class modelClass = NSClassFromString(modelClassName);
            NSString *createTableStatement = [helper createTableStatementForModelClass:modelClass];
            [db executeUpdate:createTableStatement];
        }];
    }];
}

- (NSArray<NSObject<FTGSQLiteSerializing> *> *)loadAllWithModelClass:(Class)modelClass {
    NSMutableArray *results = [NSMutableArray array];

    FTGSQLiteHelper *helper = [FTGSQLiteHelper new];

    [self.queue inDatabase:^(FMDatabase *db) {
        NSString *statement = [helper selectAllStatementForModelClass:modelClass];
        FMResultSet *set = [db executeQuery:statement];

        while ([set next]) {
            NSObject<FTGSQLiteSerializing> *model = [[modelClass alloc] init];
            [helper updateModel:model resultSet:set];
            [results addObject:model];
        }
    }];

    return results;
}

- (void)executeStatement:(NSString *)statement {
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:statement];
    }];
}

- (void)executeStatements:(NSArray<NSString *> *)statements {
    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [statements each:^(NSString *statement) {
            // TODO: executeStatements
            [db executeUpdate:statement];
        }];
    }];
}

@end
