//
//  MNFRealmSyncResponse.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

@class MNFAccountSyncStatus,MNFSyncAuthenticationChallenge;

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFRealmSyncResponse represents information when syncing to a financial data realm.
 
 A sync response should not be directly initialized but fetched from the server through MNFSynchronization.
 */
@interface MNFRealmSyncResponse : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The realm credentials id.
 */
@property (nonatomic,strong,readonly) NSNumber *realmCredentialsId;

/**
 @abstract The realm credentials display name.
 */
@property (nonatomic,copy,readonly) NSString *realmCredentialsDisplayName;

/**
 @abstract The organization identifier the realm belongs to.
 */
@property (nonatomic,strong,readonly) NSNumber *organizationId;

/**
 @abstract The organization name the realm belongs to.
 */
@property (nonatomic,copy,readonly) NSString *organizationName;

/**
 @abstract The organization bank code identifier the realm belongs to.
 */
@property (nonatomic,copy,readonly) NSString *organizationBankCode;

/**
 @abstract The list of sync statuses for each account the user has in the realm.
 */
@property (nonatomic,copy,readonly) NSArray <MNFAccountSyncStatus*> *accountSyncStatuses;

/**
 @abstract An authentication challenge to the user or null if no response is needed.
 */
@property (nonatomic,strong,readonly) MNFSyncAuthenticationChallenge *authenticationChallenge;

/**
 @abstract Whether the synchronization session is done for this realm.
 */
@property (nonatomic,strong,readonly) NSNumber *isSyncDone;

/**
 @abstract Id of the realm.
 */
@property (nonatomic,strong,readonly) NSNumber *realmId;

@end

NS_ASSUME_NONNULL_END
