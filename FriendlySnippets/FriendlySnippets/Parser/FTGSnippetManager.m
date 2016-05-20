//
//  FTGSnippetManager.m
//  FriendlySnippets
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGSnippetManager.h"
#import "FTGSnippetReader.h"
#import "FTGSnippetsParser.h"
#import "FTGSnippetSaver.h"
#import "FTGSnippet.h"

@implementation FTGSnippetManager

- (void)performParsing
{
    // Read files from bundle
    FTGSnippetReader *reader = [[FTGSnippetReader alloc] init];
    NSArray *rawSnippetFilePaths = [reader rawSnippetFilePaths];

    // Parse to Snippet
    FTGSnippetsParser *parser = [[FTGSnippetsParser alloc] init];
    NSMutableArray *snippets = [@[] mutableCopy];
    for (NSString *rawSnippetFilePath in rawSnippetFilePaths) {
        FTGSnippet *snippet = [parser snippetFromRawSnippetFilePath:rawSnippetFilePath];
        [snippets addObject:snippet];
    }

    // Save to document directory
    FTGSnippetSaver *saver = [[FTGSnippetSaver alloc] init];
    [snippets enumerateObjectsUsingBlock:^(FTGSnippet *snippet, NSUInteger idx, BOOL *stop) {
        [saver saveSnippet:snippet];
    }];
}

@end
