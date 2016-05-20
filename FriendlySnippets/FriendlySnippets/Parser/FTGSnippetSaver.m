//
//  FTGSnippetSaver.m
//  FriendlySnippets
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGSnippetSaver.h"


@implementation FTGSnippetSaver

- (void)saveSnippet:(FTGSnippet *)snippet
{
    NSMutableDictionary *rootDict = [@{} mutableCopy];

    // Completion shortcut
    rootDict[@"IDECodeSnippetCompletionPrefix"] = snippet.completionShortcut;

    // Completion scopes
    rootDict[@"IDECodeSnippetCompletionScopes"] = snippet.completionScopes;

    // Content
    rootDict[@"IDECodeSnippetContents"] = snippet.content;

    // Indentifier
    NSString *uuid = [[NSUUID UUID] UUIDString];
    rootDict[@"IDECodeSnippetIdentifier"] = uuid;

    // Language
    rootDict[@"IDECodeSnippetLanguage"] = snippet.language;

    // Platform
    //rootDict[@"IDECodeSnippetPlatformFamily"] = @"iphoneos";

    // Title
    rootDict[@"IDECodeSnippetTitle"] = snippet.title;

    // User snippet
    rootDict[@"IDECodeSnippetUserSnippet"] = @(YES);

    // Verion
    rootDict[@"IDECodeSnippetVersion"] = @(0);


    NSData *plist = [NSPropertyListSerialization dataWithPropertyList:rootDict format:NSPropertyListXMLFormat_v1_0 options:0 error:nil];

    NSString *fileName = [uuid stringByAppendingPathExtension:@"codesnippet"];
    NSString *filePath = [[self documentDirectory] stringByAppendingPathComponent:fileName];

    [plist writeToFile:filePath atomically:YES];
}

- (NSString *)documentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
