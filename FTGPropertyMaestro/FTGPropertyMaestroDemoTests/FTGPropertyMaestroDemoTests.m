//
//  FTGPropertyMaestroDemoTests.m
//  FTGPropertyMaestroDemoTests
//
//  Created by Khoa Pham on 8/26/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FTGPropertyMaestro.h"
#import "FTGProperty.h"

#import "FTGClassA.h"
#import "FTGClassA+FTGAdditions.h"
#import "FTGClassA+FTGMoreAdditions.h"
#import "FTGClassB.h"
#import "FTGClassB+FTGAdditions.h"

@interface FTGPropertyMaestroDemoTests : XCTestCase

@end

@implementation FTGPropertyMaestroDemoTests

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

- (void)testSynthesize
{
    FTGClassA *objectA = [[FTGClassA alloc] init];

    [objectA updateCategoryCopyProperty:@"Thor"];
    objectA.categoryStrongProperty = @(10);
    //objectA.categoryBoolProperty = YES;
    objectA.categoryMoreStrongProperty = @"Mjolnir";

    FTGClassB *objectB = [[FTGClassB alloc] init];
    objectB.categoryWeakProperty = objectA;

    objectB.categoryCanBeNilProperty = @"Hello";
    objectB.categoryCanBeNilProperty = nil;

    XCTAssert([objectA.categoryCopyProperty isEqualToString:@"Thor"], @"categoryCopyProperty not work");
    XCTAssert([objectA.categoryStrongProperty compare:@(10)] == NSOrderedSame, @"categortStrongProperty not work");
    //XCTAssert(objectA.categoryBoolProperty == NO, @"categoryBoolProperty not work");
    XCTAssert([objectA.categoryMoreStrongProperty isEqualToString:@"Mjolnir"], @"categoryMoreStrongProperty not work");

    XCTAssert([objectB.categoryWeakProperty isKindOfClass:[FTGClassA class]], @"categoryWeakProperty not work");
    XCTAssert(!objectB.categoryCanBeNilProperty, @"categoryCanBeNilProperty");
}

- (void)testPropertiesRetrieval
{
    NSArray *kClassAProperties = [FTGPropertyMaestro propertiesForClass:[FTGClassA class]];
    XCTAssert(kClassAProperties.count == 7, @"ClassA must have 7 properties");

    NSArray *kClassBProperties = [FTGPropertyMaestro propertiesForClass:[FTGClassB class]];
    XCTAssert(kClassBProperties.count == 2, @"ClassB must have 2 properties");
}

- (void)testSinglePropertyRetrieval
{
    FTGProperty *categoryWeakProperty = [FTGPropertyMaestro propertyForClass:[FTGClassB class]
                                                                propertyName:@"categoryWeakProperty"];

    XCTAssert([categoryWeakProperty.name isEqualToString:@"categoryWeakProperty"], @"name is wrong");
    XCTAssert(categoryWeakProperty.attributeMask & FTGPropertyAttributeWeakReference, @"attribute must be weak");
    XCTAssert([categoryWeakProperty isNonAtomic], @"attribute must be nonatomic");
}

@end
