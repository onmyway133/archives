//
//  FTGProperty.h
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/26/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef NS_OPTIONS(NSUInteger, FTGPropertyAttribute) {
    FTGPropertyAttributeNone                                = 0,
    FTGPropertyAttributeBackingIVar                         = 1 << 0,
    FTGPropertyAttributeCopy                                = 1 << 1,
    FTGPropertyAttributeDynamic                             = 1 << 2,
    FTGPropertyAttributeNonAtomic                           = 1 << 3,
    FTGPropertyAttributeReadOnly                            = 1 << 4,
    FTGPropertyAttributeRetain                              = 1 << 5,
    FTGPropertyAttributeWeakReference                       = 1 << 6,
    FTGPropertyAttributeCustomGetter                        = 1 << 7,
    FTGPropertyAttributeCustomSetter                        = 1 << 8,
    FTGPropertyAttributeTypeEncoding                        = 1 << 9,
    FTGPropertyAttributeOldTypeEncoding                     = 1 << 10,
    FTGPropertyAttributeEligibleForGarbageCollection        = 1 << 11,
};

@interface FTGProperty : NSObject

@property (nonatomic, assign, readonly) objc_property_t objcProperty;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *setterName;

@property (nonatomic, assign, readonly) FTGPropertyAttribute attributeMask;

@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, assign, readonly) BOOL isObjectType;

@property (nonatomic, copy, readonly) NSString *backingIVarName;
@property (nonatomic, copy, readonly) NSString *customGetterName;
@property (nonatomic, copy, readonly) NSString *customSetterName;

+ (instancetype)propertyWithObjcProperty:(objc_property_t)objcProperty;

- (BOOL)isDynamic;
- (BOOL)isWeak;
- (BOOL)isCopy;
- (BOOL)isStrong;
- (BOOL)isReadOnly;
- (BOOL)isNonAtomic;

- (objc_AssociationPolicy)objcAssociatedPolicy;

@end
