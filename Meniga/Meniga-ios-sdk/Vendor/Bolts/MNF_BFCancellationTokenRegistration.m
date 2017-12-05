/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "MNF_BFCancellationTokenRegistration.h"

#import "MNF_BFCancellationToken.h"

@interface MNF_BFCancellationTokenRegistration ()

@property (nonatomic, weak) MNF_BFCancellationToken *token;
@property (nonatomic, strong) MNF_BFCancellationBlock cancellationObserverBlock;
@property (nonatomic, strong) NSObject *lock;
@property (nonatomic) BOOL disposed;

@end

@interface MNF_BFCancellationToken (BFCancellationTokenRegistration)

- (void)unregisterRegistration:(MNF_BFCancellationTokenRegistration *)registration;

@end

@implementation MNF_BFCancellationTokenRegistration

+ (instancetype)registrationWithToken:(MNF_BFCancellationToken *)token delegate:(MNF_BFCancellationBlock)delegate {
    MNF_BFCancellationTokenRegistration *registration = [MNF_BFCancellationTokenRegistration new];
    registration.token = token;
    registration.cancellationObserverBlock = delegate;
    return registration;
}

- (instancetype)init {
    if (self = [super init]) {
        _lock = [NSObject new];
    }
    return self;
}

- (void)dispose {
    @synchronized(self.lock) {
        if (self.disposed) {
            return;
        }
        self.disposed = YES;
    }

    MNF_BFCancellationToken *token = self.token;
    if (token != nil) {
        [token unregisterRegistration:self];
        self.token = nil;
    }
    self.cancellationObserverBlock = nil;
}

- (void)notifyDelegate {
    @synchronized(self.lock) {
        [self throwIfDisposed];
        self.cancellationObserverBlock();
    }
}

- (void)throwIfDisposed {
    NSAssert(!self.disposed, @"Object already disposed");
}

@end
