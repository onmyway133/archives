//
//  FTGSQLiteHelper.m
//  Pods
//
//  Created by Khoa Pham on 12/7/15.
//
//

#import "FTGSQLiteHelper.h"
#import "FTGPropertyMaestro.h"
#import "ObjectiveSugar.h"
#import "FTGModelHelper.h"

@implementation FTGSQLiteHelper

- (NSString *)createTableStatementForModelClass:(Class)modelClass {
    NSParameterAssert([modelClass conformsToProtocol:@protocol(FTGSQLiteSerializing)]);

    NSMutableString *statement = [NSMutableString string];

    [statement appendFormat:@"CREATE TABLE %@ (", NSStringFromClass(modelClass)];

    FTGModelHelper *modelHelper = [FTGModelHelper new];
    NSArray *properties = [modelHelper propertiesForModelClass:modelClass];
    NSUInteger count = properties.count;

    [properties eachWithIndex:^(FTGProperty *property, NSUInteger index) {
        NSString *name = property.name;
        NSString *dataType = [self dataTypeFromProperty:property];
        NSString *primaryKey = [name isEqualToString:@"modelID"] ? @" PRIMARY KEY NOT NULL" : @"";

        [statement appendFormat:@"%@ %@ %@", name, dataType, primaryKey];

        if (index < count-1) {
            [statement appendString:@","];
        }
    }];

    [statement appendString:@")"];

    return statement;
}

- (NSString *)selectAllStatementForModelClass:(Class)modelClass {
    NSParameterAssert([modelClass conformsToProtocol:@protocol(FTGSQLiteSerializing)]);

    return [NSString stringWithFormat:@"SELECT * FROM %@", NSStringFromClass(modelClass)];
}


- (NSString *)deleteStatementForModels:(NSArray<NSObject<FTGSQLiteSerializing> *> *)models modelClass:(Class)modelClass{
    NSArray *IDs = [models map:^NSString *(NSObject<FTGSQLiteSerializing> *model) {
        return model.modelID;
    }];

    NSString *stringIDs = [IDs componentsJoinedByString:@","];

    return [NSString stringWithFormat:@"DELETE FROM %@ where modelID IN (%@)", NSStringFromClass(modelClass), stringIDs];
}

- (NSString *)insertOrUpdateStatementForModel:(NSObject<FTGSQLiteSerializing> *)model modelClass:(Class)modelClass {
    NSParameterAssert([modelClass conformsToProtocol:@protocol(FTGSQLiteSerializing)]);

    FTGModelHelper *modelHelper = [FTGModelHelper new];
    NSArray *properties = [modelHelper propertiesForModelClass:modelClass];

    NSArray *columns = [properties map:^id(FTGProperty *property) {
        return property.name;
    }];

    NSArray *values = [properties map:^id(FTGProperty *property) {
        NSString *dataType = [self dataTypeFromProperty:property];
        NSString *name = property.name;

        NSString *string = [NSString stringWithFormat:@"%@", [model valueForKey:name]];
        if ([dataType isEqualToString:@"TEXT"]) {
            string = [NSString stringWithFormat:@"'%@'", string];
        }

        return string;
    }];

    NSMutableString *statement = [NSMutableString string];

    // Insert
    [statement appendFormat:@"INSERT INTO %@", NSStringFromClass(modelClass)];
    [statement appendFormat:@"(%@)", [columns componentsJoinedByString:@","]];

    // Values
    [statement appendString:@"VALUES"];
    [statement appendFormat:@"(%@)", [values componentsJoinedByString:@","]];

    return statement;
}

- (void)updateModel:(NSObject<FTGSQLiteSerializing> *)model resultSet:(FMResultSet *)resultSet {
    FTGModelHelper *modelHelper = [FTGModelHelper new];
    NSArray *properties = [modelHelper propertiesForModelClass:[model class]];

    [properties each:^(FTGProperty *property) {
        NSString *dataType = [self dataTypeFromProperty:property];
        NSString *name = property.name;

        if ([dataType isEqualToString:@"INT"]) {
            [model setValue:@([resultSet intForColumn:name]) forKey:name];
        } else if ([dataType isEqualToString:@"REAL"]) {
            [model setValue:@([resultSet doubleForColumn:name]) forKey:name];
        } else if ([dataType isEqualToString:@"TEXT"]) {
            [model setValue:[resultSet stringForColumn:name] forKey:name];
        }
    }];
}

#pragma mark - Helper
- (NSString *)dataTypeFromProperty:(FTGProperty *)property {
    NSDictionary *mapping = @{@"q": @"INTEGER",
                              @"d": @"REAL",
                              @"B": @"NUMERIC",
                              @"NSString": @"TEXT",
                              };

    return mapping[property.type];
}

@end
