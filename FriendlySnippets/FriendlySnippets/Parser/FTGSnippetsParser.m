//
//  FTGSnippetsParser.m
//  FriendlySnippets
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import "FTGSnippetsParser.h"
#import "FTGSnippet.h"


@implementation FTGSnippetsParser


- (FTGSnippet *)snippetFromRawSnippetFilePath:(NSString *)rawSnippetFilePath
{
    NSString *fileContent = [NSString stringWithContentsOfFile:rawSnippetFilePath encoding:NSUTF8StringEncoding error:nil];
    NSScanner *scanner = [[NSScanner alloc] initWithString:fileContent];

    NSString *completionShortcut = [[rawSnippetFilePath lastPathComponent] stringByDeletingPathExtension];

    NSString *title = nil;
    [scanner scanUpToString:@"\n" intoString:&title];
    title = [self afterDoubleDashString:title];

    NSString *summary = nil;
    [scanner scanUpToString:@"\n" intoString:&summary];
    summary = [self afterDoubleDashString:summary];

    NSString *separator = nil;
    [scanner scanUpToString:@"\n" intoString:&separator];

    NSString *platform = nil;
    [scanner scanUpToString:@"\n" intoString:&platform];
    platform = [self afterColonString:platform];

    NSString *language = nil;
    [scanner scanUpToString:@"\n" intoString:&language];
    language = [self afterColonString:language];

    NSString *completionScopesString = nil;
    [scanner scanUpToString:@"\n" intoString:&completionScopesString];
    completionScopesString = [self afterColonString:completionScopesString];

    NSString *content = nil;
    [scanner scanUpToString:@"" intoString:&content];


    FTGSnippet *snippet = [[FTGSnippet alloc] init];
    snippet.completionShortcut = completionShortcut;
    snippet.title = title;
    snippet.summary = summary;
    snippet.platform = [self XCodePlatform:platform];
    snippet.language = [self XCodeLanguage:language];
    snippet.completionScopes = [self XCodeCompletionScopes:completionScopesString];
    snippet.content = [self XCodeContent:content];

    return snippet;
}

#pragma mark - Helpers
- (NSString *)afterColonString:(NSString *)string
{
    NSString *secondString = [[string componentsSeparatedByString:@":"] objectAtIndex:1];

    return [secondString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n "]];
}

- (NSString *)afterDoubleDashString:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"//" withString:@""];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n "]];
}

- (NSString *)XCodePlatform:(NSString *)platform
{
    return @"All";
}

- (NSString *)XCodeLanguage:(NSString *)language
{
    NSDictionary *mapping = @{ @"Objective-C"   : @"Xcode.SourceCodeLanguage.Objective-C",
                               @"C"             : @"Xcode.SourceCodeLanguage.C",
                               };

    return mapping[language];
}

- (NSString *)XCodeCompletionScope:(NSString *)completionScope
{
    NSDictionary *mapping = @{ @"Function or Method": @"CodeBlock",
                               @"Code Expression": @"CodeExpression",
                               @"Class Implementation": @"ClassImplementation",
                               @"Top Level": @"TopLevel",
                               @"Class Interface Methods": @"ClassInterfaceMethods",
                               @"Class Interface Variables": @"ClassInterfaceVariables",
                               @"Preprocessor": @"Preprocessor",
                               @"String or Comment": @"StringOrComment"
                              };

    return mapping[completionScope];
}

- (NSArray *)XCodeCompletionScopes:(NSString *)completionScopesString
{
    NSArray *completionScopes = [completionScopesString componentsSeparatedByString:@","];

    NSMutableArray *XCodeCompletionScopes = [@[] mutableCopy];
    [completionScopes enumerateObjectsUsingBlock:^(NSString *completionScope, NSUInteger idx, BOOL *stop) {
        completionScope = [completionScope stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *XCodeCompletionScope = [self XCodeCompletionScope:completionScope];
        [XCodeCompletionScopes addObject:XCodeCompletionScope];
    }];

    return XCodeCompletionScopes;
}

- (NSString *)XCodeContent:(NSString *)content
{
    return content;
}

@end
