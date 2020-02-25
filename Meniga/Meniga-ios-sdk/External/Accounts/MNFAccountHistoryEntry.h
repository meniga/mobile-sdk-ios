//
//  MNFAccountHistoryEntry.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFAccountHistoryEntry class represents account history data.
 
 An account history entry should not be initialized directly but rather fetched from the server through MNFAccount.
 */
@interface MNFAccountHistoryEntry : MNFObject

/**
 @abstract The account id of the history entry.
 */
@property (nonatomic, strong, readonly) NSNumber *accountId;

/**
 @abstract The balance of the history entry.
 */
@property (nonatomic, strong, readonly) NSNumber *balance;

/**
 The balance of the history entry in the users currency.
 */
@property (nonatomic, strong, readonly) NSNumber *balanceInUserCurrency;

/**
 @abstract The date of the history entry.
 */
@property (nonatomic, strong, readonly) NSDate *balanceDate;

/**
 @abstract Whether the entry has been generated with default values.
 */
@property (nonatomic, strong, readonly) NSNumber *isDefault;

@end

NS_ASSUME_NONNULL_END
