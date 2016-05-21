//
//  FTGProperty.m
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/26/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGProperty.h"

@interface FTGProperty ()

@property (nonatomic, assign, readwrite) objc_property_t objcProperty;

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *setterName;

@property (nonatomic, assign, readwrite) FTGPropertyAttribute attributeMask;

@property (nonatomic, copy, readwrite) NSString *type;
@property (nonatomic, assign, readwrite) BOOL isObjectType;

@property (nonatomic, copy, readwrite) NSString *backingIVarName;
@property (nonatomic, copy, readwrite) NSString *customGetterName;
@property (nonatomic, copy, readwrite) NSString *customSetterName;

@property (nonatomic, strong) NSMutableDictionary *attributeDict;

@end

@implementation FTGProperty

#pragma mark - Factory
+ (instancetype)propertyWithObjcProperty:(objc_property_t)objcProperty
{
    FTGProperty *property = [[FTGProperty alloc] init];

    [property updateWithObjcProperty:objcProperty];
    [property updateSetterName];

    return property;
}

#pragma mark - Useful Query
- (BOOL)isDynamic
{
    return self.attributeMask & FTGPropertyAttributeDynamic;
}

- (BOOL)isWeak
{
    return self.attributeMask & FTGPropertyAttributeWeakReference;
}

- (BOOL)isCopy
{
    return self.attributeMask & FTGPropertyAttributeCopy;
}

- (BOOL)isStrong
{
    return self.attributeMask & FTGPropertyAttributeRetain;
}

- (BOOL)isReadOnly
{
    return self.attributeMask & FTGPropertyAttributeReadOnly;
}

- (BOOL)isNonAtomic
{
    return self.attributeMask & FTGPropertyAttributeNonAtomic;
}

- (objc_AssociationPolicy)objcAssociatedPolicy
{
    if ([self isStrong]) {
        return [self isNonAtomic] ? OBJC_ASSOCIATION_RETAIN_NONATOMIC : OBJC_ASSOCIATION_RETAIN;
    }

    if ([self isCopy]) {
        return [self isNonAtomic] ? OBJC_ASSOCIATION_COPY_NONATOMIC : OBJC_ASSOCIATION_COPY;
    }

    return OBJC_ASSOCIATION_ASSIGN;
}

#pragma mark - Update With objc_property_t
- (void)updateWithObjcProperty:(objc_property_t)objcProperty
{
    // objcProperty
    self.objcProperty = objcProperty;

    // Name
    const char *cName = property_getName(objcProperty);
    self.name = [NSString stringWithUTF8String:cName];

    // Attributes
    unsigned int count;
    objc_property_attribute_t *objcAttributes = property_copyAttributeList(objcProperty, &count);

    self.attributeDict = [NSMutableDictionary dictionary];
    for(unsigned i = 0; i < count; i++) {
        objc_property_attribute_t objcAttribute = objcAttributes[i];

        // objc_property_attribute_t.value
        // The value of the attribute (usually empty).
        char *cValue = property_copyAttributeValue(objcProperty, objcAttribute.name);

        [self.attributeDict setObject:[NSString stringWithUTF8String:cValue]
                               forKey:[NSString stringWithUTF8String:objcAttribute.name]];

        free(cValue);
    }

    free(objcAttributes);

    [self updateWithAttributeDict];
}

- (void)updateWithAttributeDict
{
    self.attributeMask = 0;

    NSDictionary *encodingToAttributeMaskMapping = [self encodingToAttributeMaskMapping];
    for (NSDictionary *key in self.attributeDict.allKeys) {
        FTGPropertyAttribute attribute = [encodingToAttributeMaskMapping[key] integerValue];
        self.attributeMask |= attribute;

        NSString *value = self.attributeDict[key];
        switch (attribute) {
            case FTGPropertyAttributeBackingIVar:
                self.backingIVarName = value;
                break;
            case FTGPropertyAttributeCustomGetter:
                self.customGetterName = value;
                break;
            case FTGPropertyAttributeCustomSetter:
                self.customSetterName = value;
                break;
            case FTGPropertyAttributeTypeEncoding:
            case FTGPropertyAttributeOldTypeEncoding: {
                self.isObjectType = [value rangeOfString:@"@"].location != NSNotFound;
                self.type = [self normalizedType:value];
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - Encoding to AttributeMask
- (NSDictionary *)encodingToAttributeMaskMapping
{
    return @{@"V": @(FTGPropertyAttributeBackingIVar),
             @"C": @(FTGPropertyAttributeCopy),
             @"D": @(FTGPropertyAttributeDynamic),
             @"N": @(FTGPropertyAttributeNonAtomic),
             @"R": @(FTGPropertyAttributeReadOnly),
             @"&": @(FTGPropertyAttributeRetain),
             @"W": @(FTGPropertyAttributeWeakReference),
             @"G": @(FTGPropertyAttributeCustomGetter),
             @"S": @(FTGPropertyAttributeCustomSetter),
             @"T": @(FTGPropertyAttributeTypeEncoding),
             @"t": @(FTGPropertyAttributeOldTypeEncoding),
             @"P": @(FTGPropertyAttributeEligibleForGarbageCollection),
             };
}

#pragma mark - Helper
- (NSString *)normalizedType:(NSString *)type
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@\""];
    return [type stringByTrimmingCharactersInSet:set];
}

- (void)updateSetterName
{
    NSString *capitalizedFirstLetterString = [self capitalizedFirstLetterString:self.name];

    self.setterName = [NSString stringWithFormat:@"set%@:", capitalizedFirstLetterString];
}

- (NSString *)capitalizedFirstLetterString:(NSString *)string
{
    NSString *firstLetter = [[string substringToIndex:1] uppercaseString];
    return [firstLetter stringByAppendingString:[self.name substringFromIndex:1]];
}

@end
