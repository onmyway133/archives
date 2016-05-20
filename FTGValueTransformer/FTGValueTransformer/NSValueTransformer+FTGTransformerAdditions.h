//
//  NSValueTransformer+FTGTransformerAdditions.h
//  FTGValueTransformerDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const FTGNumberValueTransformerName;
extern NSString * const FTGStringValueTransformerName;

@interface NSValueTransformer (FTGTransformerAdditions)

/**
 *  Creates a reversible transformer to convert the first object of an array of JSON dictionaries into a MTLModel object, 
 *  and convert the MTLModel back to an array of one JSON dictionary.
 *
 *  @param modelClass The MTLModel subclass to attempt to parse from the JSON. This class must conform to <MTLJSONSerializing>. 
 *  This argument must not be nil.
 *
 *  @return Returns a reversible transformer which uses MTLJSONAdapter for transforming 
 *  values back and forth
 */
+ (NSValueTransformer *)ftg_JSONFirstObjectInArrayTransformerWithModelClass:(Class)modelClass;

/**
 *  Creates a reversible transformer to convert NSNumber to NSString, and vice versa.
 *
 *  @return Returns a reversible transformer
 */
+ (NSValueTransformer *)ftg_stringValueTransformer;

/**
 *  Creates a reversible transformer to convert NSString to NSNumber, and vice versa.
 *
 *  @return Returns a reversible transformer
 */
+ (NSValueTransformer *)ftg_numberValueTransformer;

@end
