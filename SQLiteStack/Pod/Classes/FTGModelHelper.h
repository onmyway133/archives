//
//  FTGModelHelper.h
//  Pods
//
//  Created by Khoa Pham on 12/7/15.
//
//

#import <Foundation/Foundation.h>
#import "FTGPropertyMaestro.h"

@interface FTGModelHelper : NSObject

/**
 *  Retrieve properties for a certain model class
 *
 *  @param modelClass class of the model
 *
 *  @return an array of property infos
 */
- (NSArray<FTGProperty *> *)propertiesForModelClass:(Class)modelClass;

@end
