//
//  RACSignal+FTGDot.h
//  DotReactiveCocoaDemo
//
//  Created by Khoa Pham on 4/11/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "RACSignal.h"

typedef BOOL (^FTGPredicate)(id x);
typedef void (^FTGBlock)();
typedef id (^FTGReduceBlock)(id running, id next);
typedef id (^FTGReduceWithIndexBlock)(id running, id next, NSUInteger index);

typedef RACSignal * (^FTGInputSignalOutputSignal)(RACSignal *signal);
typedef RACSignal * (^FTGInputNoneOutputSignal)(void);
typedef RACSignal * (^FTGInputTimeIntervalOutputSignal)(NSTimeInterval timeInterval);
typedef RACSignal * (^FTGInputTimeIntervalPredicateOutputSignal)(NSTimeInterval interval, FTGPredicate predicate);
typedef RACSignal * (^FTGInputBlockOutputSignal)(FTGBlock block);
typedef RACSignal * (^FTGInputTimeIntervalSchedulerOutputSignal)(NSTimeInterval interval, RACScheduler *scheduler);
typedef RACSignal * (^FTGInputUnsignedIntegerOutputSignal)(NSUInteger uInteger);
typedef RACSignal * (^FTGInputInputNoneOutputSignalOutputSignal)(FTGInputNoneOutputSignal inputNoneOutputSignal);
typedef RACSignal * (^FTGInputStartReduceBlockOutputSignal)(id start, FTGReduceBlock reduceBlock);
typedef RACSignal * (^FTGInputStartReduceWithIndexBlockOutputSignal)(id start, FTGReduceWithIndexBlock reduceBlock);
typedef RACSignal * (^FTGInputPredicateOutputSignal)(FTGPredicate block);

typedef void (^FTGNextBlock)(id x);
typedef void (^FTGCompletedBlock)();
typedef void (^FTGErrorBlock)(NSError *error);

@interface RACSignal (FTGDot)

#pragma mark - RACStream
- (FTGInputSignalOutputSignal)ftg_concat;
- (FTGInputSignalOutputSignal)ftg_zipWith;

#pragma mark - RACSubscription
- (RACDisposable *(^)(id<RACSubscriber> subscriber))ftg_subscribe;
- (RACDisposable *(^)(FTGNextBlock nextBlock))ftg_subscribeNext;
- (RACDisposable *(^)(FTGNextBlock nextBlock, FTGCompletedBlock completedBlock))ftg_subscribeNextCompleted;
- (RACDisposable *(^)(FTGNextBlock nextBlock, FTGErrorBlock errorBlock, FTGCompletedBlock completedBlock))ftg_subscribeNextErrorCompleted;
- (RACDisposable *(^)(FTGErrorBlock errorBlock))ftg_subscribeError;
- (RACDisposable *(^)(FTGCompletedBlock completedBlock))ftg_subscribeCompleted;
- (RACDisposable *(^)(FTGNextBlock nextBlock, FTGErrorBlock errorBlock))ftg_subscribeNextError;
- (RACDisposable *(^)(FTGErrorBlock errorBlock, FTGCompletedBlock completedBlock))ftg_subscribeErrorCompleted;

#pragma mark - Debugging
- (FTGInputNoneOutputSignal)ftg_logAll;
- (FTGInputNoneOutputSignal)ftg_logNext;
- (FTGInputNoneOutputSignal)ftg_logError;
- (FTGInputNoneOutputSignal)ftg_logCompleted;

#pragma mark - Operations
- (RACSignal * (^)(FTGNextBlock block))ftg_doNext;
- (RACSignal * (^)(FTGErrorBlock block))ftg_doError;
- (RACSignal * (^)(FTGCompletedBlock block))ftg_doCompleted;

- (FTGInputTimeIntervalOutputSignal)ftg_throttle;
- (FTGInputTimeIntervalPredicateOutputSignal)ftg_throttlePredicate;

- (FTGInputTimeIntervalOutputSignal)ftg_delay;
- (FTGInputNoneOutputSignal)ftg_repeat;

- (FTGInputBlockOutputSignal)ftg_initially;
- (FTGInputBlockOutputSignal)ftg_finally;

- (FTGInputTimeIntervalSchedulerOutputSignal)ftg_bufferWithTimeOnScheduler;

- (FTGInputNoneOutputSignal)ftg_collect;

- (FTGInputUnsignedIntegerOutputSignal)ftg_takeLast;

- (FTGInputSignalOutputSignal)ftg_combineLatestWith;
- (FTGInputSignalOutputSignal)ftg_merge;
- (FTGInputUnsignedIntegerOutputSignal)ftg_flatten;

- (FTGInputInputNoneOutputSignalOutputSignal)ftg_then;
- (FTGInputNoneOutputSignal)ftg_concatInner;

- (FTGInputStartReduceBlockOutputSignal)ftg_aggregateWithStartReduce;
- (FTGInputStartReduceWithIndexBlockOutputSignal)ftg_aggregateWithStartReduceWithIndex;

#pragma mark - RACStream
- (FTGInputPredicateOutputSignal)ftg_filter;

@end
