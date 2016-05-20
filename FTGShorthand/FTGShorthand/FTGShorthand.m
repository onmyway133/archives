//
//  FTGShorthand.m
//  FTGShorthandDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGShorthand.h"
#import <objc/runtime.h>

@implementation FTGShorthand

static NSString *sPrefix;

// Dynamic shorthand method helpers
BOOL addShortHandMethodToPrefixedClassMethod(Class class, SEL selector);
BOOL addShorthandMethodToPrefixedInstanceMethod(Class klass, SEL originalSelector);

void replaceSelectorForTargetWithSourceImpAndSwizzle(Class originalClass, SEL originalSelector, Class newClass, SEL newSelector);


#pragma mark - Public Interface
+ (void)setPrefix:(NSString *)prefix
{
    NSCAssert(sPrefix == nil, @"Prefix needs to be set once");
    NSCAssert(prefix.length > 0, @"Prefix must not be empty");

    sPrefix = prefix;
}

+ (void)supportShorthandMethodsForClass:(Class)kClass
{
    NSCAssert(sPrefix.length > 0, @"Prefix hasn't been set");

    [self supportShorthandMethodsForClasses:@[ kClass ]];
}

+ (void)supportShorthandMethodsForClasses:(NSArray *)classes
{
    NSCAssert(sPrefix.length > 0, @"Prefix hasn't been set");

    [classes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Class klass = (Class)obj;
        [self updateResolveMethodsForClass:klass];
    }];
}

#pragma mark - Resolve
// In order to add support for non-prefixed AND prefixed methods, we need to swap the existing resolveClassMethod: and resolveInstanceMethod: implementations with the one in this class.
+ (void)updateResolveMethodsForClass:(Class)klass
{
    replaceSelectorForTargetWithSourceImpAndSwizzle(self, @selector(FTG_resolveClassMethod:), klass, @selector(resolveClassMethod:));
    replaceSelectorForTargetWithSourceImpAndSwizzle(self, @selector(FTG_resolveInstanceMethod:), klass, @selector(resolveInstanceMethod:));
}

+ (BOOL)FTG_resolveClassMethod:(SEL)originalSelector
{
    BOOL resolvedClassMethod = [self FTG_resolveClassMethod:originalSelector];
    if (!resolvedClassMethod)
    {
        resolvedClassMethod = addShortHandMethodToPrefixedClassMethod(self, originalSelector);
    }
    return resolvedClassMethod;
}

+ (BOOL)FTG_resolveInstanceMethod:(SEL)originalSelector
{
    BOOL resolvedClassMethod = [self FTG_resolveInstanceMethod:originalSelector];
    if (!resolvedClassMethod)
    {
        resolvedClassMethod = addShorthandMethodToPrefixedInstanceMethod(self, originalSelector);
    }
    return resolvedClassMethod;
}

@end


#pragma mark - Support functions for runtime shorthand Method calling
void replaceSelectorForTargetWithSourceImpAndSwizzle(Class sourceClass, SEL sourceSelector, Class targetClass, SEL targetSelector)
{
    Method sourceClassMethod = class_getClassMethod(sourceClass, sourceSelector);
    Method targetClassMethod = class_getClassMethod(targetClass, targetSelector);

    Class targetMetaClass = objc_getMetaClass([NSStringFromClass(targetClass) cStringUsingEncoding:NSUTF8StringEncoding]);

    BOOL methodWasAdded = class_addMethod(targetMetaClass, sourceSelector,
                                          method_getImplementation(targetClassMethod),
                                          method_getTypeEncoding(targetClassMethod));

    if (methodWasAdded)
    {
        class_replaceMethod(targetMetaClass, targetSelector,
                            method_getImplementation(sourceClassMethod),
                            method_getTypeEncoding(sourceClassMethod));
    }
}

BOOL addShorthandMethodToPrefixedInstanceMethod(Class klass, SEL originalSelector)
{
    NSString *originalSelectorString = NSStringFromSelector(originalSelector);
    if ([originalSelectorString hasPrefix:@"_"] || [originalSelectorString hasPrefix:@"init"]) {
        return NO;
    }

    if (![originalSelectorString hasPrefix:sPrefix])
    {
        NSString *prefixedSelector = [sPrefix stringByAppendingString:originalSelectorString];
        Method existingMethod = class_getInstanceMethod(klass, NSSelectorFromString(prefixedSelector));

        if (existingMethod)
        {
            BOOL methodWasAdded = class_addMethod(klass,
                                                  originalSelector,
                                                  method_getImplementation(existingMethod),
                                                  method_getTypeEncoding(existingMethod));

            return methodWasAdded;
        }
    }
    return NO;
}


BOOL addShortHandMethodToPrefixedClassMethod(Class klass, SEL originalSelector)
{
    NSString *originalSelectorString = NSStringFromSelector(originalSelector);
    if (![originalSelectorString hasPrefix:sPrefix])
    {
        NSString *prefixedSelector = [sPrefix stringByAppendingString:originalSelectorString];
        Method existingMethod = class_getClassMethod(klass, NSSelectorFromString(prefixedSelector));

        if (existingMethod)
        {
            Class metaClass = objc_getMetaClass([NSStringFromClass(klass) cStringUsingEncoding:NSUTF8StringEncoding]);
            BOOL methodWasAdded = class_addMethod(metaClass,
                                                  originalSelector,
                                                  method_getImplementation(existingMethod),
                                                  method_getTypeEncoding(existingMethod));

            return methodWasAdded;
        }
    }
    return NO;
}

