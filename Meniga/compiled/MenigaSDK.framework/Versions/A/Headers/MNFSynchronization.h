//
//  MNFSynchronization.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 10/12/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

@class MNFRealmSyncResponse;
@class MNFRealmAccount;
@class MNFSyncAuthenticationChallenge;

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

+ (MNFJob*)synchronizeRealmUserWithId:(NSNumber *)realmUserId timeout:(NSNumber*)timeout interval:(NSNumber*)interval completin:(nullable MNFErrorOnlyCompletionHandler)completion;

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

+(MNFJob*)startSynchronizationForRealmUserWithId:(NSNumber*)realmUserId waitTime:(NSNumber*)waitTime completion:(nullable MNFSynchronizationCompletionHandler)completion;

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

///******************************
/// @name Realm authentication
///******************************

/**
 Fetch an authentication challenge with a realm id. This will tell you the methods and parameters the bank with the given realm id requires you to fulfill to authenticate a user.
 
 @param realmId The realm id of the organization to authenticate to.
 @param completion A completion block returning an authentication challenge and an error.
 
 @return MNFJob A job containing an authentication challenge and an error.
 */
+ (MNFJob *)fetchRealmAuthenticationChallengeWithRealmId:(NSNumber *)realmId completion:(nullable MNFSyncAuthenticationCompletionHandler)completion;

/**
 Authenticate to an organization with a given realm id with the required parameters.
 
 @param realmId The realm id of the organization to authenticate to.
 @param parameters A list of key-value pairs for the parameters. The key-value pairs should be 'name' for the parameter name and 'value' for the corresponding value.
 @param saveDetails Whether the details should be saved.
 @param realmUserIdentifier The user identifier for the user in the context of the realm.
 @param completion A completion block returning an authentication challenge and an error.
 
 @return MNFJob A job containing an authentication challenge and an error.
 */
+ (MNFJob *)authenticateToRealmWithId:(NSNumber *)realmId withParameters:(nullable NSArray <NSDictionary *> *)parameters sessionToken:(nullable NSString *)sessionToken saveDetails:(nullable NSNumber *)saveDetails realmUserIdentifier:(nullable NSString *)realmUserIdentifier completion:(nullable MNFSyncAuthenticationCompletionHandler)completion;

/**
 Fetches the realm accounts available to the user.
 
 @param realmUserId The realm id of the user.
 @param sessionToken The session token which is added as a query so we know you are a properly authenticated user. The session token is url encoded.
 @param completion A completion block returning a list of realm accounts and an error.
 
 @return MNFJob A job containing a list of realm accounts and an error.
 */
+ (MNFJob *)fetchAvailableRealmAccountsWithRealmUserId:(NSNumber *)realmUserId sessionToken:(nullable NSString *)sessionToken completion:(nullable MNFMultipleRealmAccountCompletionHandler)completion;

/**
 Authorizes a list of realm accounts.
 
 @param realmAccounts The realm accounts to authorize.
 @param realmUserId The realm id of the user.
 @param sessionToken The session token which is added as a query so we know you are a properly authenticated user. The session token is url encoded.
 @param completion A completion block returning a list of realm accounts and an error.
 
 
 @return MNFJob A job containing a list of realm accounts and an error.
 */
+ (MNFJob *)authorizeRealmAccounts:(NSArray <MNFRealmAccount*> *)realmAccounts realmUserId:(NSNumber *)realmUserId sessionToken:(nullable NSString *)sessionToken completion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
