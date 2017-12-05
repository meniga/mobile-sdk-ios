/*
 *  Copyright (c) 2014, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import "MNF_BoltsVersion.h"
#import "MNF_BFCancellationToken.h"
#import "MNF_BFCancellationTokenRegistration.h"
#import "MNF_BFCancellationTokenSource.h"
#import "MNF_BFExecutor.h"
#import "MNF_BFTask.h"
#import "MNF_BFTaskCompletionSource.h"


/*! @abstract 80175001: There were multiple errors. */
extern NSInteger const kMNF_BFMultipleErrorsError;

@interface MNF_Bolts : NSObject

/*!
 Returns the version of the Bolts Framework as an NSString.
 @returns The NSString representation of the current version.
 */
+ (NSString *)version;

@end
