//
//  FTGValueTransformerDemoTests.m
//  FTGValueTransformerDemoTests
//
//  Created by Khoa Pham on 8/22/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FTGUser.h"
#import "FTGBook.h"

@interface FTGValueTransformerDemoTests : XCTestCase

@end

@implementation FTGValueTransformerDemoTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFTGValueTransformer
{
    NSString *jsonFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"user" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];

    NSDictionary *userDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    FTGUser *user = [MTLJSONAdapter modelOfClass:[FTGUser class] fromJSONDictionary:userDict error:nil];

    XCTAssert([user.score isKindOfClass:[NSNumber class]], @"FTGUser.score must be of type NSNumber");
    XCTAssert([user.favoriteBook.name isEqualToString:@"iOS Programming"], @"favoriteBook.name must be iOS Programming");
    
}

@end
