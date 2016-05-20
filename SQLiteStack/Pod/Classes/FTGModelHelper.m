//
//  FTGModelHelper.m
//  Pods
//
//  Created by Khoa Pham on 12/7/15.
//
//

#import "FTGModelHelper.h"
#import "FTGSQLiteSerializing.h"
#import "ObjectiveSugar.h"

// Used to cache properties
static void *kFTGModelHelperPropertiesKey = &kFTGModelHelperPropertiesKey;

@implementation FTGModelHelper

- (NSArray<FTGProperty *> *)propertiesForModelClass:(Class)modelClass {
    NSParameterAssert([modelClass conformsToProtocol:@protocol(FTGSQLiteSerializing)]);

    NSArray *properties = nil;

    properties = objc_getAssociatedObject(modelClass, kFTGModelHelperPropertiesKey);
    if (properties != nil) {
        return properties;
    }

    NSMutableArray *tempProperties = [NSMutableArray array];

    // Only work with this class 
//    [tempProperties addObjectsFromArray:[FTGPropertyMaestro propertiesForClass:[modelClass superclass]]];
    [tempProperties addObjectsFromArray:[FTGPropertyMaestro propertiesForClass:modelClass]];

    // Only interested in our declared properties
    NSArray *keys = [modelClass propertyKeys];

    properties = [tempProperties select:^BOOL(FTGProperty *property) {
        return [keys containsObject:property.name];
    }];

    objc_setAssociatedObject(modelClass, kFTGModelHelperPropertiesKey, properties, OBJC_ASSOCIATION_COPY);

    return properties;
}

@end
