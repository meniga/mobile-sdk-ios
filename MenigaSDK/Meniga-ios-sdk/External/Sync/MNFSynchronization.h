//
//  MNFSynchronization.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 10/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

@class MNFRealmSyncResponse;

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFSynchronization class encapsulates synchronization data from the server in an object.
 
 A synchronization object should not be directly initialized but rather fetched through the server when performing synchronization.
 */
@interface MNFSynchronization : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The sync history identifier of this synchronization.
 */
@property (nonatomic,strong,readonly) NSNumber *syncHistoryId;

/**
 @abstract Whether the synchronization is completed.
 */
@property (nonatomic,strong,readonly) NSNumber *isSyncDone;

/**
 @abstract The starting date of the synchronization session.
 */
@property (nonatomic,strong,readonly) NSDate *syncSessionStartTime;

/**
 @abstract Response information from the financial realm being synchronized to.
 */
@property (nonatomic,strong,readonly) NSArray <MNFRealmSyncResponse *> *realmSyncResponses;

///******************************
/// @name Sync and wait
///******************************

/**
 Starts synchronization of financial data, and waits until synchronization is completed. Returns an error if the synchronization did not complete before the timeout period.
 
 @param timeout The number of milliseconds to wait before cancelling the task in the background.
 @param interval The number of milliseconds to wait between queries of synchronization status.
 @param completion A completion block returning an error.
 
 @note All queries and waits are performed on a background thread until the request either times out or synchronization is completed. The completion block fires on the main thread.
 
 @return An MNFJob containing a result or an error.
 */
+(MNFJob*)synchronizeWithTimeout:(NSNumber*)timeout interval:(NSNumber*)interval completion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Start synchronization
///******************************

/**
 @abstract Starts synchronization of financial data and returns a synchronization object with information on the sync session.
 
 @param waitTime The number of milliseconds to wait before cancelling the task in the background.
 @param completion A completion block returning a synchronization object and an error.
 
 @return An MNFJob containing a synchronization object and an error.
 */
+(MNFJob*)startSynchronizationWithWaitTime:(NSNumber *)waitTime completion:(nullable MNFSynchronizationCompletionHandler)completion;

///******************************
/// @name Synchronization status
///******************************

/**
 @abstract Get the synchronization status of this synchronization session and updates the object.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Get the current synchronization status for the user.
 
 @param completion A completion block returning a synchronization object and an error.
 
 @return An MNFJob containing a synchronization object and an error.
 */
+(MNFJob*)fetchCurrentSynchronizationStatusWithCompletion:(nullable MNFSynchronizationCompletionHandler)completion;

/**
 @abstract Find out whether synchronization is needed
 
 @return A boolean indicating whether synchronization is needed.
 
 @warning
 */
-(BOOL)isSynchronizationNeeded;

@end

NS_ASSUME_NONNULL_END