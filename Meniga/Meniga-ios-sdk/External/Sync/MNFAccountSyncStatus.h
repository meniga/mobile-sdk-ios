//
//  MNFAccountSyncStatus.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFAccountSyncStatus represents sync status information for an account in a realm being synchronized.
 
 An account sync status should not be directly initialized.
*/
@interface MNFAccountSyncStatus : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The id of the account.
 */
@property (nonatomic, strong, readonly) NSNumber *accountId;

/**
 @abstract The balance of the account.
 */
@property (nonatomic, strong, readonly) NSNumber *balance;

/**
 @abstract The limit or overdraft of the account.
 */
@property (nonatomic, strong, readonly) NSNumber *limit;

/**
 @abstract Total number of transactions that has already been processed during this synchronization.
 */
@property (nonatomic, strong, readonly) NSNumber *transactionsProcessed;

/**
 @abstract Total number of transaction to process during this synchronization session or null if the number of transactions is still unknown.
 */
@property (nonatomic, strong, readonly) NSNumber *totalTransactions;

/**
 @abstract The date and time when synchronization of this account started or null if synchronization hasn't started yet.
 */
@property (nonatomic, strong, readonly) NSDate *startDate;

/**
 @abstract The date and time when synchronization of this account completed or null if synchronization hasn't completed yet.
 */
@property (nonatomic, strong, readonly) NSDate *endDate;

/**
 @abstract External status of the account. This is how a custom extension data connector can set a status that is returned in when synchronization is started or checked.
 */
@property (nonatomic, copy, readonly) NSString *accountStatus;

/**
 @abstract The status of the account synchronization. Available values:  Success, ConsentNotFound, AccountNotFound, TooManyRequests, ProviderNotFound, ProviderDisabled or SyncFailed
 */
@property (nonatomic, copy, readonly) NSString *status;

@end

NS_ASSUME_NONNULL_END
