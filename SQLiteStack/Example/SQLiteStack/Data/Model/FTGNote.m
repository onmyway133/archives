//
//  FTGNote.m
//  SQLiteStack
//
//  Created by Khoa Pham on 12/7/15.
//  Copyright © 2015 Khoa Pham. All rights reserved.
//

#import "FTGNote.h"

@implementation FTGNote

+ (NSArray<NSString *> *)propertyKeys {
    return @[@"modelID",
             @"content",
             @"timeInterval",
             ];
}

@end
