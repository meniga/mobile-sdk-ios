/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "MNF_BFCancellationTokenSource.h"

#import "MNF_BFCancellationToken.h"

@interface MNF_BFCancellationToken (BFCancellationTokenSource)

- (void)cancel;
- (void)cancelAfterDelay:(int)millis;

- (void)dispose;
- (void)throwIfDisposed;

@end

@implementation MNF_BFCancellationTokenSource

#pragma mark - Initializer

- (instancetype)init {
    self = [super init];
    if (!self) return nil;

    _token = [MNF_BFCancellationToken new];

    return self;
}

+ (instancetype)cancellationTokenSource {
    return [MNF_BFCancellationTokenSource new];
}

#pragma mark - Custom Setters/Getters

- (BOOL)isCancellationRequested {
    return _token.isCancellationRequested;
}

- (void)cancel {
    [_token cancel];
}

- (void)cancelAfterDelay:(int)millis {
    [_token cancelAfterDelay:millis];
}

- (void)dispose {
    [_token dispose];
}

@end
