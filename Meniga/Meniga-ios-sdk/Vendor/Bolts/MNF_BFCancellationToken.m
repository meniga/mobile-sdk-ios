/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "MNF_BFCancellationToken.h"
#import "MNF_BFCancellationTokenRegistration.h"

@interface MNF_BFCancellationToken ()

@property (atomic, assign, getter=isCancellationRequested) BOOL cancellationRequested;
@property (nonatomic, strong) NSMutableArray *registrations;
@property (nonatomic, strong) NSObject *lock;
@property (nonatomic) BOOL disposed;

@end

@interface MNF_BFCancellationTokenRegistration (BFCancellationToken)

+ (instancetype)registrationWithToken:(MNF_BFCancellationToken *)token delegate:(MNF_BFCancellationBlock)delegate;

- (void)notifyDelegate;

@end

@implementation MNF_BFCancellationToken

#pragma mark - Initializer

- (instancetype)init {
    if (self = [super init]) {
        _registrations = [NSMutableArray array];
        _lock = [NSObject new];
    }
    return self;
}

#pragma mark - Custom Setters/Getters

- (BOOL)isCancellationRequested {
    @synchronized(self.lock) {
        [self throwIfDisposed];
        return _cancellationRequested;
    }
}

- (void)cancel {
    NSArray *registrations;
    @synchronized(self.lock) {
        [self throwIfDisposed];
        if (_cancellationRequested) {
            return;
        }
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelPrivate) object:nil];
        _cancellationRequested = YES;
        registrations = [self.registrations copy];
    }

    [self notifyCancellation:registrations];
}

- (void)notifyCancellation:(NSArray *)registrations {
    for (MNF_BFCancellationTokenRegistration *registration in registrations) {
        [registration notifyDelegate];
    }
}

- (MNF_BFCancellationTokenRegistration *)registerCancellationObserverWithBlock:(MNF_BFCancellationBlock)block {
    @synchronized(self.lock) {
        MNF_BFCancellationTokenRegistration *registration = [MNF_BFCancellationTokenRegistration registrationWithToken:self delegate:[block copy]];
        [self.registrations addObject:registration];

        return registration;
    }
}

- (void)unregisterRegistration:(MNF_BFCancellationTokenRegistration *)registration {
    @synchronized(self.lock) {
        [self throwIfDisposed];
        [self.registrations removeObject:registration];
    }
}

// Delay on a non-public method to prevent interference with a user calling performSelector or
// cancelPreviousPerformRequestsWithTarget on the public method
- (void)cancelPrivate {
    [self cancel];
}

- (void)cancelAfterDelay:(int)millis {
    [self throwIfDisposed];
    NSAssert(millis >= -1, @"Delay must be >= -1");

    if (millis == 0) {
        [self cancel];
        return;
    }

    @synchronized(self.lock) {
        [self throwIfDisposed];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(cancelPrivate) object:nil];
        if (self.cancellationRequested) {
            return;
        }

        if (millis != -1) {
            double delay = (double)millis / 1000;
            [self performSelector:@selector(cancelPrivate) withObject:nil afterDelay:delay];
        }
    }
}

- (void)dispose {
    @synchronized(self.lock) {
        if (self.disposed) {
            return;
        }
        self.disposed = YES;
        for (MNF_BFCancellationTokenRegistration *registration in self.registrations) {
            [registration dispose];
        }
        [self.registrations removeAllObjects];
    }
}

- (void)throwIfDisposed {
    NSAssert(!self.disposed, @"Object already disposed");
}

@end
