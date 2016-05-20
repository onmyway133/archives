//
//  NSValueTransformer+FTGTransformerAdditions.m
//  FTGValueTransformerDemo
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "NSValueTransformer+FTGTransformerAdditions.h"
#import <Mantle/Mantle.h>

NSString * const FTGNumberValueTransformerName = @"FTGNumberValueTransformerName";
NSString * const FTGStringValueTransformerName = @"FTGStringValueTransformerName";

@implementation NSValueTransformer (FTGTransformerAdditions)

#pragma mark - Category Loading

+ (void)load {
	@autoreleasepool {
		NSValueTransformer *stringValueTransformer = [self ftg_stringValueTransformer];
		[NSValueTransformer setValueTransformer:stringValueTransformer forName:FTGStringValueTransformerName];

        NSValueTransformer *numberValueTransformer = [self ftg_numberValueTransformer];
		[NSValueTransformer setValueTransformer:numberValueTransformer forName:FTGNumberValueTransformerName];
	}
}

#pragma mark - Transformer
+ (NSValueTransformer *)ftg_JSONFirstObjectInArrayTransformerWithModelClass:(Class)modelClass {
	NSValueTransformer *dictionaryTransformer = [self mtl_JSONDictionaryTransformerWithModelClass:modelClass];

	return [MTLValueTransformer
            reversibleTransformerWithForwardBlock:^ id (NSArray *dictionaries) {
                if (dictionaries == nil || dictionaries.count == 0) {
                    return nil;
                }

                NSAssert([dictionaries isKindOfClass:NSArray.class], @"Expected a array of dictionaries, got: %@", dictionaries);

                NSDictionary *firstDictionary = [dictionaries firstObject];

                NSAssert([firstDictionary isKindOfClass:NSDictionary.class], @"Expected a dictionary or an NSNull, got: %@", firstDictionary);

                id model = [dictionaryTransformer transformedValue:firstDictionary];

                return model;
            }
            reverseBlock:^ id (id model) {
                if (model == nil) {
                    return nil;
                }

                NSAssert([model isKindOfClass:MTLModel.class], @"Expected an MTLModel or an NSNull, got: %@", model);

                NSDictionary *dict = [dictionaryTransformer reverseTransformedValue:model];

                if (dict) {
                    return @[ dict ];
                }

                return @[];
            }];
}

+ (NSValueTransformer *)ftg_stringValueTransformer {
    NSValueTransformer *stringValueTransformer = [MTLValueTransformer
                                                  reversibleTransformerWithBlock:^ id (NSNumber *number) {
                                                      if (![number isKindOfClass:NSNumber.class]) {
                                                          return  nil;
                                                      }
                                                      
                                                      return number.stringValue;
                                                  }];

    return stringValueTransformer;
}

+ (NSValueTransformer *)ftg_numberValueTransformer {
    NSValueTransformer *numberValueTransformer = [MTLValueTransformer
                                                  reversibleTransformerWithBlock:^ id (NSString *string) {
                                                      if (![string isKindOfClass:NSString.class]) {
                                                          return  nil;
                                                      }
                                                      
                                                      return @(string.integerValue);
                                                  }];
    
    return numberValueTransformer;
}

@end
