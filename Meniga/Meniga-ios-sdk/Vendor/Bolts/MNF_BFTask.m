/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "MNF_BFTask.h"

#import <libkern/OSAtomic.h>

#import "MNF_Bolts.h"

__attribute__ ((noinline)) void MNF_warnBlockingOperationOnMainThread() {
    NSLog(@"Warning: A long-running operation is being executed on the main thread. \n"
          " Break on warnBlockingOperationOnMainThread() to debug.");
}

NSString *const MNF_BFTaskErrorDomain = @"MNF_bolts";
NSString *const MNF_BFTaskMultipleExceptionsException = @"MNF_BFMultipleExceptionsException";

@interface MNF_BFTask () {
    id _result;
    id _metaData;
    NSError *_error;
    NSException *_exception;
}

@property (atomic, assign, readwrite, getter=isCancelled) BOOL cancelled;
@property (atomic, assign, readwrite, getter=isFaulted) BOOL faulted;
@property (atomic, assign, readwrite, getter=isCompleted) BOOL completed;

@property (nonatomic, strong) NSObject *lock;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) NSMutableArray *callbacks;

@end

@implementation MNF_BFTask

#pragma mark - Initializer

- (instancetype)init {
    if (self = [super init]) {
        _lock = [[NSObject alloc] init];
        _condition = [[NSCondition alloc] init];
        _callbacks = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Task Class methods

+ (instancetype)taskWithResult:(id)result {
    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    tcs.result = result;
    return tcs.task;
}

+ (instancetype)taskWithResult:(id)result metaData:(id)metaData {
    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    [tcs setResult:result];
    [tcs setMetaData:metaData];
    
    return tcs.task;
}

+ (instancetype)taskWithError:(NSError *)error {
    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    tcs.error = error;
    return tcs.task;
}

+ (instancetype)taskWithException:(NSException *)exception {
    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    tcs.exception = exception;
    return tcs.task;
}

+ (instancetype)cancelledTask {
    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    [tcs cancel];
    return tcs.task;
}

+ (instancetype)taskForCompletionOfAllTasks:(NSArray *)tasks {
    __block int32_t total = (int32_t)tasks.count;
    if (total == 0) {
        return [self taskWithResult:nil];
    }

    __block int32_t cancelled = 0;
    NSObject *lock = [[NSObject alloc] init];
    NSMutableArray *errors = [NSMutableArray array];
    NSMutableArray *exceptions = [NSMutableArray array];

    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    for (MNF_BFTask *task in tasks) {
        [task continueWithBlock:^id(MNF_BFTask *task) {
            if (task.exception) {
                @synchronized (lock) {
                    [exceptions addObject:task.exception];
                }
            } else if (task.error) {
                @synchronized (lock) {
                    [errors addObject:task.error];
                }
            } else if (task.cancelled) {
                OSAtomicIncrement32(&cancelled);
            }

            if (OSAtomicDecrement32(&total) == 0) {
                if (exceptions.count > 0) {
                    if (exceptions.count == 1) {
                        tcs.exception = [exceptions firstObject];
                    } else {
                        NSException *exception =
                        [NSException exceptionWithName:MNF_BFTaskMultipleExceptionsException
                                                reason:@"There were multiple exceptions."
                                              userInfo:@{ @"exceptions": exceptions }];
                        tcs.exception = exception;
                    }
                } else if (errors.count > 0) {
                    if (errors.count == 1) {
                        tcs.error = [errors firstObject];
                    } else {
                        NSError *error = [NSError errorWithDomain:MNF_BFTaskErrorDomain
                                                             code:kMNF_BFMultipleErrorsError
                                                         userInfo:@{ @"errors": errors }];
                        tcs.error = error;
                    }
                } else if (cancelled > 0) {
                    [tcs cancel];
                } else {
                    tcs.result = nil;
                }
            }
            return nil;
        }];
    }
    return tcs.task;
}

+ (instancetype)taskForCompletionOfAllTasksWithResults:(NSArray *)tasks {
    return [[self taskForCompletionOfAllTasks:tasks] continueWithSuccessBlock:^id(MNF_BFTask *task) {
        return [tasks valueForKey:@"result"];
    }];
}

+ (instancetype)taskWithDelay:(int)millis {
    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, millis * NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        tcs.result = nil;
    });
    return tcs.task;
}

+ (instancetype)taskWithDelay:(int)millis
            cancellationToken:(MNF_BFCancellationToken *)token {
    if (token.cancellationRequested) {
        return [MNF_BFTask cancelledTask];
    }

    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, millis * NSEC_PER_MSEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        if (token.cancellationRequested) {
            [tcs cancel];
            return;
        }
        tcs.result = nil;
    });
    return tcs.task;
}

+ (instancetype)taskFromExecutor:(MNF_BFExecutor *)executor
                       withBlock:(id (^)())block {
    return [[self taskWithResult:nil] continueWithExecutor:executor withBlock:block];
}

#pragma mark - Custom Setters/Getters

- (id)result {
    @synchronized(self.lock) {
        return _result;
    }
}

- (void)setResult:(id)result {
    if (![self trySetResult:result]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Cannot set the result on a completed task."];
    }
}

- (BOOL)trySetResult:(id)result {
    @synchronized(self.lock) {
        if (self.completed) {
            return NO;
        }
        self.completed = YES;
        _result = result;
        [self runContinuations];
        return YES;
    }
}

- (id)metaData {
    @synchronized(self.lock) {
        return _metaData;
    }
}

- (void)setMetaData:(id)metaData {
    
    @synchronized(self.lock) {
        
        if (self.isCompleted == NO) {
            _metaData = metaData;
        }
        
    }
    /*
    if ([self trySetMetaData:metaData] == NO) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Cannot set the metadata on a completed task."];
    }
     */
}

-(BOOL)trySetMetaData:(id)metaData {
    @synchronized(self.lock) {
        if (self.completed == YES) {
            return NO;
        }
        self.completed = YES;
        _metaData = metaData;
        [self runContinuations];
        return YES;
    }
}

- (NSError *)error {
    @synchronized(self.lock) {
        return _error;
    }
}

- (void)setError:(NSError *)error {
    if (![self trySetError:error]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Cannot set the error on a completed task."];
    }
}

- (BOOL)trySetError:(NSError *)error {
    @synchronized(self.lock) {
        if (self.completed) {
            return NO;
        }
        self.completed = YES;
        self.faulted = YES;
        _error = error;
        [self runContinuations];
        return YES;
    }
}

- (NSException *)exception {
    @synchronized(self.lock) {
        return _exception;
    }
}

- (void)setException:(NSException *)exception {
    if (![self trySetException:exception]) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"Cannot set the exception on a completed task."];
    }
}

- (BOOL)trySetException:(NSException *)exception {
    @synchronized(self.lock) {
        if (self.completed) {
            return NO;
        }
        self.completed = YES;
        self.faulted = YES;
        _exception = exception;
        [self runContinuations];
        return YES;
    }
}

- (BOOL)isCancelled {
    @synchronized(self.lock) {
        return _cancelled;
    }
}

- (BOOL)isFaulted {
    @synchronized(self.lock) {
        return _faulted;
    }
}

- (void)cancel {
    @synchronized(self.lock) {
        if (![self trySetCancelled]) {
            [NSException raise:NSInternalInconsistencyException
                        format:@"Cannot cancel a completed task."];
        }
    }
}

- (BOOL)trySetCancelled {
    @synchronized(self.lock) {
        if (self.completed) {
            return NO;
        }
        self.completed = YES;
        self.cancelled = YES;
        [self runContinuations];
        return YES;
    }
}

- (BOOL)isCompleted {
    @synchronized(self.lock) {
        return _completed;
    }
}

- (void)setCompleted {
    @synchronized(self.lock) {
        _completed = YES;
    }
}

- (void)runContinuations {
    @synchronized(self.lock) {
        [self.condition lock];
        [self.condition broadcast];
        [self.condition unlock];
        for (void (^callback)() in self.callbacks) {
            callback();
        }
        [self.callbacks removeAllObjects];
    }
}

#pragma mark - Chaining methods

- (instancetype)continueWithExecutor:(MNF_BFExecutor *)executor
                           withBlock:(MNF_BFContinuationBlock)block {
    return [self continueWithExecutor:executor block:block cancellationToken:nil];
}

- (instancetype)continueWithExecutor:(MNF_BFExecutor *)executor
                               block:(MNF_BFContinuationBlock)block
                   cancellationToken:(MNF_BFCancellationToken *)cancellationToken {
    MNF_BFTaskCompletionSource *tcs = [MNF_BFTaskCompletionSource taskCompletionSource];

    // Capture all of the state that needs to used when the continuation is complete.
    void (^wrappedBlock)() = ^() {
        [executor execute:^{
            if (cancellationToken.cancellationRequested) {
                [tcs cancel];
                return;
            }

            id result = nil;
            @try {
                result = block(self);
            } @catch (NSException *exception) {
                tcs.exception = exception;
                return;
            }

            if ([result isKindOfClass:[MNF_BFTask class]]) {

                id (^setupWithTask) (MNF_BFTask *) = ^id(MNF_BFTask *task) {
                    if (cancellationToken.cancellationRequested || task.cancelled) {
                        [tcs cancel];
                    } else if (task.exception) {
                        tcs.exception = task.exception;
                    } else if (task.error) {
                        tcs.error = task.error;
                    } else {
                        tcs.result = task.result;
                    }
                    return nil;
                };

                MNF_BFTask *resultTask = (MNF_BFTask *)result;

                if (resultTask.completed) {
                    setupWithTask(resultTask);
                } else {
                    [resultTask continueWithBlock:setupWithTask];
                }

            } else {
                tcs.result = result;
            }
        }];
    };

    BOOL completed;
    @synchronized(self.lock) {
        completed = self.completed;
        if (!completed) {
            [self.callbacks addObject:[wrappedBlock copy]];
        }
    }
    if (completed) {
        wrappedBlock();
    }

    return tcs.task;
}

- (instancetype)continueWithBlock:(MNF_BFContinuationBlock)block {
    return [self continueWithExecutor:[MNF_BFExecutor defaultExecutor] block:block cancellationToken:nil];
}

- (instancetype)continueWithBlock:(MNF_BFContinuationBlock)block
                cancellationToken:(MNF_BFCancellationToken *)cancellationToken {
    return [self continueWithExecutor:[MNF_BFExecutor defaultExecutor] block:block cancellationToken:cancellationToken];
}

- (instancetype)continueWithExecutor:(MNF_BFExecutor *)executor
                    withSuccessBlock:(MNF_BFContinuationBlock)block {
    return [self continueWithExecutor:executor successBlock:block cancellationToken:nil];
}

- (instancetype)continueWithExecutor:(MNF_BFExecutor *)executor
                        successBlock:(MNF_BFContinuationBlock)block
                   cancellationToken:(MNF_BFCancellationToken *)cancellationToken {
    if (cancellationToken.cancellationRequested) {
        return [MNF_BFTask cancelledTask];
    }

    return [self continueWithExecutor:executor block:^id(MNF_BFTask *task) {
        if (task.faulted || task.cancelled) {
            return task;
        } else {
            return block(task);
        }
    } cancellationToken:cancellationToken];
}

- (instancetype)continueWithSuccessBlock:(MNF_BFContinuationBlock)block {
    return [self continueWithExecutor:[MNF_BFExecutor defaultExecutor] successBlock:block cancellationToken:nil];
}

- (instancetype)continueWithSuccessBlock:(MNF_BFContinuationBlock)block
                       cancellationToken:(MNF_BFCancellationToken *)cancellationToken {
    return [self continueWithExecutor:[MNF_BFExecutor defaultExecutor] successBlock:block cancellationToken:cancellationToken];
}

#pragma mark - Syncing Task (Avoid it)

- (void)warnOperationOnMainThread {
    MNF_warnBlockingOperationOnMainThread();
}

- (void)waitUntilFinished {
    if ([NSThread isMainThread]) {
        [self warnOperationOnMainThread];
    }

    @synchronized(self.lock) {
        if (self.completed) {
            return;
        }
        [self.condition lock];
    }
    [self.condition wait];
    [self.condition unlock];
}

#pragma mark - NSObject

- (NSString *)description {
    // Acquire the data from the locked properties
    BOOL completed;
    BOOL cancelled;
    BOOL faulted;

    @synchronized(self.lock) {
        completed = self.completed;
        cancelled = self.cancelled;
        faulted = self.faulted;
    }

    // Description string includes status information and, if available, the
    // result since in some ways this is what a promise actually "is".
    return [NSString stringWithFormat:@"<%@: %p; completed = %@; cancelled = %@; faulted = %@;%@>",
            NSStringFromClass([self class]),
            self,
            completed ? @"YES" : @"NO",
            cancelled ? @"YES" : @"NO",
            faulted ? @"YES" : @"NO",
            completed ? [NSString stringWithFormat:@" result:%@", _result] : @""];
}

@end
