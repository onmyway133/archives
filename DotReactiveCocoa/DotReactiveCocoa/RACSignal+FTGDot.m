//
//  RACSignal+FTGDot.m
//  DotReactiveCocoaDemo
//
//  Created by Khoa Pham on 4/11/15.
//  Copyright (c) 2015 Fantageek. All rights reserved.
//

#import "RACSignal+FTGDot.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation RACSignal (FTGDot)

#pragma mark - RACStream
- (FTGInputSignalOutputSignal)ftg_concat {
    return ^(RACSignal *signal){
        return [self concat:signal];
    };
}

- (FTGInputSignalOutputSignal)ftg_zipWith {
    return ^(RACSignal *signal){
        return [self zipWith:signal];
    };
}


#pragma mark - RACSubscription
- (RACDisposable *(^)(id<RACSubscriber> subscriber))ftg_subscribe {
    return ^(id<RACSubscriber> subscriber){
        return [self subscribe:subscriber];
    };
}

- (RACDisposable *(^)(FTGNextBlock nextBlock))ftg_subscribeNext {
    return ^(void (^nextBlock)(id x)){
        return [self subscribeNext:nextBlock];
    };
}

- (RACDisposable *(^)(FTGNextBlock nextBlock, FTGCompletedBlock completedBlock))ftg_subscribeNextCompleted {
    return ^(FTGNextBlock nextBlock, FTGCompletedBlock completedBlock){
        return [self subscribeNext:nextBlock completed:completedBlock];
    };
}

- (RACDisposable *(^)(FTGNextBlock nextBlock, FTGErrorBlock errorBlock, FTGCompletedBlock completedBlock))ftg_subscribeNextErrorCompleted {
    return ^(FTGNextBlock nextBlock, FTGErrorBlock errorBlock, FTGCompletedBlock completedBlock){
        return [self subscribeNext:nextBlock error:errorBlock completed:completedBlock];
    };
}

- (RACDisposable *(^)(FTGErrorBlock errorBlock))ftg_subscribeError {
    return ^(FTGErrorBlock errorBlock){
        return [self subscribeError:errorBlock];
    };
}

- (RACDisposable *(^)(FTGCompletedBlock completedBlock))ftg_subscribeCompleted {
    return ^(FTGCompletedBlock completedBlock){
        return [self subscribeCompleted:completedBlock];
    };
}

- (RACDisposable *(^)(FTGNextBlock nextBlock, FTGErrorBlock errorBlock))ftg_subscribeNextError {
    return ^(FTGNextBlock nextBlock, FTGErrorBlock errorBlock){
        return [self subscribeNext:nextBlock error:errorBlock];
    };
}

- (RACDisposable *(^)(FTGErrorBlock errorBlock, FTGCompletedBlock completedBlock))ftg_subscribeErrorCompleted {
    return ^(FTGErrorBlock errorBlock, FTGCompletedBlock completedBlock){
        return [self subscribeError:errorBlock completed:completedBlock];
    };
}

#pragma mark - Debugging
- (FTGInputNoneOutputSignal)ftg_logAll {
    return ^(){
        return [self logAll];
    };
}

- (FTGInputNoneOutputSignal)ftg_logNext {
    return ^(){
        return [self logNext];
    };
}

- (FTGInputNoneOutputSignal)ftg_logError {
    return ^(){
        return [self logError];
    };
}

- (FTGInputNoneOutputSignal)ftg_logCompleted {
    return ^(){
        return [self logCompleted];
    };
}

#pragma mark - Operators
- (RACSignal * (^)(FTGNextBlock block))ftg_doNext {
    return ^(FTGNextBlock block){
        return [self doNext:block];
    };
}

- (RACSignal * (^)(FTGErrorBlock block))ftg_doError {
    return ^(FTGErrorBlock block){
        return [self doNext:block];
    };
}

- (RACSignal * (^)(FTGCompletedBlock block))ftg_doCompleted {
    return ^(FTGCompletedBlock block){
        return [self doNext:block];
    };
}

- (FTGInputTimeIntervalOutputSignal)ftg_throttle {
    return ^(NSTimeInterval interval){
        return [self throttle:interval];
    };
}

- (FTGInputTimeIntervalPredicateOutputSignal)ftg_throttlePredicate {
    return ^(NSTimeInterval interval, FTGPredicate predicate){
        return [self throttle:interval valuesPassingTest:predicate];
    };
}

- (FTGInputTimeIntervalOutputSignal)ftg_delay {
    return ^(NSTimeInterval interval){
        return [self delay:interval];
    };
}

- (FTGInputNoneOutputSignal)ftg_repeat {
    return ^{
        return [self repeat];
    };
}

- (FTGInputBlockOutputSignal)ftg_initially {
    return ^(FTGBlock block) {
        return [self initially:block];
    };
}

- (FTGInputBlockOutputSignal)ftg_finally {
    return ^(FTGBlock block) {
        return [self finally:block];
    };
}

- (FTGInputTimeIntervalSchedulerOutputSignal)ftg_bufferWithTimeOnScheduler {
    return ^(NSTimeInterval interval, RACScheduler *scheduler) {
        return [self bufferWithTime:interval onScheduler:scheduler];
    };
}

- (FTGInputNoneOutputSignal)ftg_collect {
    return ^{
        return [self collect];
    };
}

- (FTGInputUnsignedIntegerOutputSignal)ftg_takeLast {
    return ^(NSUInteger count){
        return [self takeLast:count];
    };
}

- (FTGInputSignalOutputSignal)ftg_combineLatestWith {
    return ^(RACSignal *signal){
        return [self combineLatestWith:signal];
    };
}

- (FTGInputSignalOutputSignal)ftg_merge {
    return ^(RACSignal *signal){
        return [self merge:signal];
    };
}

- (FTGInputUnsignedIntegerOutputSignal)ftg_flatten {
    return ^(NSUInteger maxConcurrent){
        return [self flatten:maxConcurrent];
    };
}

- (FTGInputInputNoneOutputSignalOutputSignal)ftg_then {
    return ^(FTGInputNoneOutputSignal inputNoneOutputSignal) {
        return [self then:inputNoneOutputSignal];
    };
}

- (FTGInputNoneOutputSignal)ftg_concatInner {
    return ^{
        return [self concat];
    };
}

- (FTGInputStartReduceBlockOutputSignal)ftg_aggregateWithStartReduce {
    return ^(id start, FTGReduceBlock reduceBlock) {
        return [self aggregateWithStart:start reduce:reduceBlock];
    };
}

- (FTGInputStartReduceWithIndexBlockOutputSignal)ftg_aggregateWithStartReduceWithIndex {
    return ^(id start, FTGReduceWithIndexBlock reduceBlock) {
        return [self aggregateWithStart:start reduceWithIndex:reduceBlock];
    };
}

#pragma mark - RACStream
- (FTGInputPredicateOutputSignal)ftg_filter {
    return ^(FTGPredicate block) {
        return [self filter:block];
    };
}

@end
