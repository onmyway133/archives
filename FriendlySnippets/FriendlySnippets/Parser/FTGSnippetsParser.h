//
//  FTGSnippetsParser.h
//  FriendlySnippets
//
//  Created by Khoa Pham on 6/1/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTGSnippet.h"

@interface FTGSnippetsParser : NSObject

- (FTGSnippet *)snippetFromRawSnippetFilePath:(NSString *)rawSnippetFilePath;

@end
