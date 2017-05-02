/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "MNF_BFTaskCompletionSource.h"

#import "MNF_BFTask.h"

@interface MNF_BFTaskCompletionSource ()

@property (nonatomic, strong, readwrite) MNF_BFTask *task;

@end

@interface MNF_BFTask (BFTaskCompletionSource)

- (void)setResult:(id)result;
- (void)setMetaData:(id)metaData;
- (void)setError:(NSError *)error;
- (void)setException:(NSException *)exception;
- (void)cancel;
- (BOOL)trySetResult:(id)result;
- (BOOL)trySetError:(NSError *)error;
- (BOOL)trySetException:(NSException *)exception;
- (BOOL)trySetCancelled;

@end

@implementation MNF_BFTaskCompletionSource

#pragma mark - Initializer

+ (instancetype)taskCompletionSource {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _task = [[MNF_BFTask alloc] init];
    }
    return self;
}

#pragma mark - Custom Setters/Getters

- (void)setResult:(id)result {
    [self.task setResult:result];
}

-(void)setMetaData:(id)metaData {
    [self.task setMetaData:metaData];
}

- (void)setError:(NSError *)error {
    [self.task setError:error];
}

- (void)setException:(NSException *)exception {
    [self.task setException:exception];
}

- (void)cancel {
    [self.task cancel];
}

- (BOOL)trySetResult:(id)result {
    return [self.task trySetResult:result];
}

- (BOOL)trySetError:(NSError *)error {
    return [self.task trySetError:error];
}

- (BOOL)trySetException:(NSException *)exception {
    return [self.task trySetException:exception];
}

- (BOOL)trySetCancelled {
    return [self.task trySetCancelled];
}

@end
