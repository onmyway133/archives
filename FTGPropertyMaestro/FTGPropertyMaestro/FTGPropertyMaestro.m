//
//  FTGPropertyMaestro.m
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/26/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGPropertyMaestro.h"
#import <objc/runtime.h>

static char kAssociatedPropertyDictKey;

@interface FTGPropertyMaestro ()

@end

@implementation FTGPropertyMaestro

+ (NSArray *)propertiesForClass:(Class)kClass
{
    unsigned int count;
    objc_property_t *objcProperties = class_copyPropertyList(kClass, &count);

    NSMutableArray *properties = [NSMutableArray array];
    for(unsigned i = 0; i < count; i++) {
        objc_property_t objcProperty = objcProperties[i];
        FTGProperty *property = [FTGProperty propertyWithObjcProperty:objcProperty];
        [properties addObject:property];
    }

    free(objcProperties);

    return [NSArray arrayWithArray:properties];
}

+ (FTGProperty *)propertyForClass:(Class)kClass
                     propertyName:(NSString *)propertyName
{
    NSArray *properties = [self propertiesForClass:kClass];
    for (FTGProperty *property in properties) {
        if ([property.name isEqualToString:propertyName]) {
            return property;
        }
    }
    
    return nil;
}

+ (void)synthesizeClass:(Class)kClass
          propertyNames:(NSArray *)propertyNames
{
    // Filter
    NSMutableArray *filteredProperties = [NSMutableArray array];
    NSArray *properties = [self propertiesForClass:kClass];
    for (FTGProperty *property in properties) {
        
        if (![self validateProperty:property]) {
            continue;
        }

        if ([propertyNames containsObject:property.name]) {
            [filteredProperties addObject:property];
        }
    }

    [self synthesizeClass:kClass properties:filteredProperties];
}

+ (void)synthesizeClass:(Class)kClass
propertyNamesWithPrefix:(NSString *)prefix
{
    // Filter
    NSMutableArray *filteredProperties = [NSMutableArray array];
    NSArray *properties = [self propertiesForClass:kClass];
    for (FTGProperty *property in properties) {

        if (![self validateProperty:property]) {
            continue;
        }

        if ([property.name hasPrefix:prefix]) {
            [filteredProperties addObject:property];
        }
    }

    [self synthesizeClass:kClass properties:filteredProperties];
}

+ (void)synthesizeClass:(Class)kClass
             properties:(NSArray *)properties
{
    // associatedPropertyDict is used to retrive FTGProperty from _cmd inside getter and setter
    [self updateAssociatedPropertyDictForClass:kClass properties:properties];

    for (FTGProperty *property in properties) {

        if (property.customGetterName.length > 0) {
            [self replaceGetterForClass:kClass selector:NSSelectorFromString(property.customGetterName)];
        } else {
            [self replaceGetterForClass:kClass selector:NSSelectorFromString(property.name)];
        }

        if (property.customSetterName.length > 0) {
            [self replaceSetterForClass:kClass selector:NSSelectorFromString(property.customSetterName)];
        } else {
            [self replaceSetterForClass:kClass selector:NSSelectorFromString(property.setterName)];
        }
    }
}

#pragma mark - Validate
+ (BOOL)validateProperty:(FTGProperty *)property
{
    // NSCAssert(property.isObjectType, @"Property must have object type");
    // NSCAssert(!property.backingIVarName, @"Property must not have backing instance variable");

    return property.isObjectType && !property.backingIVarName;
}

#pragma mark - Associated Property Dict
+ (void)updateAssociatedPropertyDictForClass:(Class)kClass properties:(NSArray *)properties
{
    NSMutableDictionary *associatedPropertyDict = objc_getAssociatedObject(kClass, &kAssociatedPropertyDictKey);
    if (!associatedPropertyDict) {
        associatedPropertyDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(kClass, &kAssociatedPropertyDictKey, associatedPropertyDict, OBJC_ASSOCIATION_RETAIN);
    }

    for (FTGProperty *property in properties) {
        // When inside FTG_getter, _cmd is always customGetterName if it exists, else name
        if (property.customGetterName.length > 0) {
            [associatedPropertyDict setObject:property forKey:property.customGetterName];
        } else {
            [associatedPropertyDict setObject:property forKey:property.name];
        }

        // When inside FTG_setter, _cmd is always customSetterName if it exists, else setterName
        if (property.customSetterName.length > 0) {
            [associatedPropertyDict setObject:property forKey:property.customSetterName];
        } else {
            [associatedPropertyDict setObject:property forKey:property.setterName];
        }
    }
}

+ (FTGProperty *)associatedPropertyForClass:(Class)kClass key:(NSString *)key
{
    NSMutableDictionary *associatedPropertyDict = objc_getAssociatedObject(kClass, &kAssociatedPropertyDictKey);
    return associatedPropertyDict[key];
}

#pragma mark - Swizzle
+ (void)replaceGetterForClass:(Class)kClass selector:(SEL)originalSelector
{
    Method ftgGetterMethod = class_getInstanceMethod(self, @selector(FTG_getter));
    Method originalMethod = class_getInstanceMethod(kClass, originalSelector);

    class_replaceMethod(kClass, originalSelector, method_getImplementation(ftgGetterMethod), method_getTypeEncoding(originalMethod));
}

+ (void)replaceSetterForClass:(Class)kClass selector:(SEL)originalSelector
{
    Method ftgSetterMethod = class_getInstanceMethod(self, @selector(FTG_setter:));
    Method originalMethod = class_getInstanceMethod(kClass, originalSelector);

    class_replaceMethod(kClass, originalSelector, method_getImplementation(ftgSetterMethod), method_getTypeEncoding(originalMethod));
}

#pragma mark - Instance Getter and Setter
- (id)FTG_getter
{
    FTGProperty *property = [FTGPropertyMaestro associatedPropertyForClass:[self class] key:NSStringFromSelector(_cmd)];

    return objc_getAssociatedObject(self, NSSelectorFromString(property.name));
}

- (void)FTG_setter:(id)value
{
    FTGProperty *property = [FTGPropertyMaestro associatedPropertyForClass:[self class] key:NSStringFromSelector(_cmd)];

    objc_setAssociatedObject(self, NSSelectorFromString(property.name), value, [property objcAssociatedPolicy]);
}

@end
