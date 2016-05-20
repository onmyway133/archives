//
//  FTGNotificationControllerDemoTests.m
//  FTGNotificationControllerDemoTests
//
//  Created by Khoa Pham on 6/19/14.
//  Copyright (c) 2014 Fantageek. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "FTGNotificationController.h"
#import "FTGTestObserver.h"

static NSString *const kNotificationName1 = @"kNotificationName1";
static NSString *const kNotificationName2 = @"kNotificationName2";

@interface FTGNotificationController (FTGNotificationControllerDemoTests)

- (NSArray *)infos;

@end

SPEC_BEGIN(FTGNotificationControllerDemoTests)

describe(@"FTGNotificationControllerDemoTests", ^{
    context(@"default context", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];

        it(@"should correctly create notification controller", ^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];

            [[sut shouldNot] beNil];
            [[sut.observer should] equal:testObserver];
        });
    });

    context(@"duplication context", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];
            [sut observeNotificationName:kNotificationName1
                                  object:nil
                                  action:@selector(handleNotification:)];

            [sut observeNotificationName:kNotificationName1
                                  object:nil
                                  action:@selector(handleNotification:)];
        });

        it(@"notification controller should have 2 notification info", ^{
            [[[sut valueForKey:@"infos"] should] haveCountOf:2];
        });

        it(@"observer should receive action twice", ^{
            [[testObserver should] receive:@selector(handleNotification:) withCount:2];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:nil
                                                              userInfo:@{}];
        });
    });

    context(@"removal context", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];
            [sut observeNotificationName:kNotificationName1
                                  object:nil
                                  action:@selector(handleNotification:)];
        });

        it(@"notification controller should have 1 notification info", ^{
            [[[sut valueForKey:@"infos"] should] haveCountOf:1];
        });

        it(@"observer correctly unobserve", ^{
            [sut unobserveNotificationName:kNotificationName1 object:nil];
            [[[sut valueForKey:@"infos"] should] haveCountOf:0];

            [[testObserver shouldNot] receive:@selector(handleNotification:)];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:nil
                                                              userInfo:@{}];
        });
    });

    context(@"removal context with 2 observed notification", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];
        __block NSString *object = @"Object";

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];
            [sut observeNotificationName:kNotificationName1
                                  object:object
                                  action:@selector(handleNotification:)];

            [sut observeNotificationName:kNotificationName1
                                  object:nil
                                  action:@selector(handleNotification:)];
        });

        it(@"notification controller should have 1 notification info", ^{
            [[[sut valueForKey:@"infos"] should] haveCountOf:2];
        });

        it(@"observer correctly unobserve", ^{
            [sut unobserveNotificationName:kNotificationName1 object:nil];
            [[[sut valueForKey:@"infos"] should] haveCountOf:1];

            [[testObserver should] receive:@selector(handleNotification:) withCount:1];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:object
                                                              userInfo:@{}];
        });
    });

    context(@"with notification controller observing 1 notification with action", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];
            [sut observeNotificationName:kNotificationName1
                                  object:nil
                                  action:@selector(handleNotification:)];
        });

        it(@"notification controller should have 1 notification info", ^{
            [[[sut valueForKey:@"infos"] should] haveCountOf:1];
        });

        it(@"observer should receive action", ^{
            [[testObserver should] receive:@selector(handleNotification:)];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:nil
                                                              userInfo:@{}];

        });
    });

    context(@"with notification controller observing 2 notifications with action", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];
            [sut observeNotificationName:kNotificationName1
                                  object:nil
                                  action:@selector(handleNotification:)];

            [sut observeNotificationName:kNotificationName2
                                  object:nil
                                  action:@selector(handleNotification:)];
        });

        it(@"notification controller should have 2 notification infos", ^{
            [[[sut valueForKey:@"infos"] should] haveCountOf:2];
        });

        it(@"observer should receive action twice", ^{
            [[testObserver should] receive:@selector(handleNotification:) withCount:2];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:nil
                                                              userInfo:@{}];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName2
                                                                object:nil
                                                              userInfo:@{}];
            
        });
    });

    context(@"with notification controller observing 1 notification with block", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];
        __block NSNumber *isBlockCalled = @(NO);
        __block id receivedObserver = nil;

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];

            [sut observeNotificationName:kNotificationName1
                                  object:nil
                                   queue:[NSOperationQueue mainQueue]
                                   block:^(NSNotification *note, id observer)
            {
                isBlockCalled = @(YES);
                receivedObserver = observer;
            }];
        });

        it(@"notification controller should have 1 notification info", ^{
            [[[sut valueForKey:@"infos"] should] haveCountOf:1];
        });

        it(@"observer should have block called", ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:nil
                                                              userInfo:@{}];
            //[[isBlockCalled should] beTrue];
        });

        it(@"should receive correct observer", ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:nil
                                                              userInfo:@{}];

            [[receivedObserver shouldEventually] equal:testObserver];
        });
    });

    context(@"notification with object", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];
        __block NSString *object = @"Object";
        __block NSString *wrongObject = @"Wrong Object";

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];
            [sut observeNotificationName:kNotificationName1
                                  object:object
                                  action:@selector(handleNotification:)];
        });

        it(@"observer should receive action", ^{
            [[testObserver should] receive:@selector(handleNotification:)];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:object
                                                              userInfo:@{}];
            
        });

        it(@"observer should not receive action if specifying wrong object", ^{
            [[testObserver shouldNot] receive:@selector(handleNotification:)];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:wrongObject
                                                              userInfo:@{}];
        });
    });

    context(@"2 notifications with same name but different objects", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];
        __block NSString *object1 = @"Object 1";
        __block NSString *object2 = @"Object 2";

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];
            [sut observeNotificationName:kNotificationName1
                                  object:object1
                                  action:@selector(handleNotification:)];

            [sut observeNotificationName:kNotificationName1
                                  object:object2
                                  action:@selector(handleNotification:)];
        });

        it(@"observer should receive action once if specifying object 1", ^{
            [[testObserver should] receive:@selector(handleNotification:) withCount:1];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:object1
                                                              userInfo:@{}];
        });

        it(@"observer should not receive action if specifying nil object", ^{
            [[testObserver shouldNot] receive:@selector(handleNotification:)];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:nil
                                                              userInfo:@{}];
        });


    });

    context(@"2 notifications with same name but nil object", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];
        __block NSString *object = @"Object";

        beforeAll(^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];
            [sut observeNotificationName:kNotificationName1
                                  object:object
                                  action:@selector(handleNotification:)];

            [sut observeNotificationName:kNotificationName1
                                  object:nil
                                  action:@selector(handleNotification:)];
        });

        it(@"observer should receive action once if specifying nil object", ^{
            [[testObserver should] receive:@selector(handleNotification:) withCount:1];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:nil
                                                              userInfo:@{}];
        });

        it(@"observer should receive action twice if specifying object", ^{
            [[testObserver should] receive:@selector(handleNotification:) withCount:2];

            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationName1
                                                                object:object
                                                              userInfo:@{}];
        });
    });

    context(@"dealloc context", ^{
        __block FTGNotificationController *sut = nil;
        __block FTGTestObserver *testObserver = [[FTGTestObserver alloc] init];

        it(@"should call unobserveAll when set to nil", ^{
            sut = [FTGNotificationController controllerWithObserver:testObserver];

            // TODO test dealloc scenario
            //[[sut shouldEventually] receive:@selector(unobserveAll)];

            sut = nil;
        });
    });
});

SPEC_END
