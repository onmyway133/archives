//
//  FTGSnippetReader.m
//  FriendlySnippets
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGSnippetReader.h"

static NSString *const kRawSnippetExtension = @"rs";

@implementation FTGSnippetReader

- (NSArray *)rawSnippetFilePaths
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];

    NSArray *resourceFileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcePath error:nil];

    NSArray *rawSnippetFileNames = [resourceFileNames filteredArrayUsingPredicate:
                                    [NSPredicate predicateWithBlock:^BOOL(NSString *resourceFilePath, NSDictionary *bindings) {
        return [[resourceFilePath pathExtension] isEqualToString:kRawSnippetExtension];
    }]];

    NSMutableArray *rawSnippetFilePaths = [@[] mutableCopy];
    [rawSnippetFileNames enumerateObjectsUsingBlock:^(NSString *rawSnippetFileName, NSUInteger idx, BOOL *stop) {
        NSString *rawSnippetFilePath = [resourcePath stringByAppendingPathComponent:rawSnippetFileName];
        [rawSnippetFilePaths addObject:rawSnippetFilePath];
    }];
    
    return rawSnippetFilePaths;
}

@end
