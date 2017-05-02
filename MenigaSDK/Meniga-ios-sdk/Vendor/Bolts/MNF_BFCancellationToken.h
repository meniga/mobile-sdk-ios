/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <Foundation/Foundation.h>

#import "MNF_BFCancellationTokenRegistration.h"

/*!
 A block that will be called when a token is cancelled.
 */
typedef void(^MNF_BFCancellationBlock)();

/*!
 The consumer view of a CancellationToken.
 Propagates notification that operations should be canceled.
 A BFCancellationToken has methods to inspect whether the token has been cancelled.
 */
@interface MNF_BFCancellationToken : NSObject

/*!
 Whether cancellation has been requested for this token source.
 */
@property (nonatomic, assign, readonly, getter=isCancellationRequested) BOOL cancellationRequested;

/*!
 Register a block to be notified when the token is cancelled.
 If the token is already cancelled the delegate will be notified immediately.
 */
- (MNF_BFCancellationTokenRegistration *)registerCancellationObserverWithBlock:(MNF_BFCancellationBlock)block;

@end
