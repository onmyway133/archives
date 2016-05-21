//
//  FTGPropertyMaestro.h
//  FTGPropertyMaestroDemo
//
//  Created by Khoa Pham on 8/26/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTGProperty.h"

@interface FTGPropertyMaestro : NSObject

/**
 *  Return an array of FTGProperty for kClass.
 *
 *  @param kClass The Class
 *
 *  @return An array of FTGProperty
 */
+ (NSArray *)propertiesForClass:(Class)kClass;

/**
 *  Return FTGProperty for kClass.
 *
 *  @param kClass       The Class
 *  @param propertyName The property name, as you declare it
 *
 *  @return FTGProperty
 */
+ (FTGProperty *)propertyForClass:(Class)kClass
                     propertyName:(NSString *)propertyName;

/**
 *  Add getter and setter using associated objects for the properties. Note that this only applies to properties of object type and do not have backing instance variable. You should declare your property as dynamic to suppress warnings.
 *
 *  @param kClass        The Class
 *  @param propertyNames An array of property name
 */
+ (void)synthesizeClass:(Class)kClass
          propertyNames:(NSArray *)propertyNames;

/**
 *  Add getter and setter using associated objects for the properties. Note that this only applies to properties of object type and do not have backing instance variable. You should declare your property as dynamic to suppress warnings.
 *
 *  @param kClass The Class
 *  @param prefix Prefix of your property names
 */
+ (void)synthesizeClass:(Class)kClass
propertyNamesWithPrefix:(NSString *)prefix;

@end
