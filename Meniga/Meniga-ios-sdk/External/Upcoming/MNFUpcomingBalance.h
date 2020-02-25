//
//  MNFUpcomingBalance.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@class MNFUpcomingBalanceDate;

/**
 The MNFUpcomingBalance class contains information of upcomings from today in a list of dates with balance.
 */
@interface MNFUpcomingBalance : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The starting balance for the balance projections, calculated as yesterday's closing balance + todaysTransactionsAmount.
 */
@property (nonatomic, strong, readonly) NSNumber *startBalance;

/**
 The projected end balance for the requested period.s
 */
@property (nonatomic, strong, readonly) NSNumber *endBalance;

/**
 A sum of today's transactions amounts for the accounts selected.
 */
@property (nonatomic, strong, readonly) NSNumber *todaysTransactionsAmount;

/**
 The currency of the upcoming transaction.
 */
@property (nonatomic, copy, readonly) NSString *currency;

/**
 A list of dates and their predictes balances.
 */
@property (nonatomic, copy, readonly) NSArray<MNFUpcomingBalanceDate *> *balanceDates;

/**
 Fetches upcoming balances from to day  until the specified date.
 
 @param dateTo The inclusive end date of the entries to be fetched.
 @param overdueFromDate When set the open upcoming transactions from this date (inclusive) are projected to today's balance.
 @param accountIds A comma seperated string of account ids to filter by.
 @param includeUnlinked Whether upcomings that are not linked to any account should be included.
 @param useAvailableAmount Whether the amount of accounts should be the available amount or the real amount.
 @param completion A completion block returning a balance and an error.
 
 @return MNFJob A job containing a balance and an error.
 */
+ (MNFJob *)fetchBalancesWithDateTo:(NSDate *)dateTo
             includeOverdueFromDate:(nullable NSDate *)overdueFromDate
                         accountIds:(nullable NSString *)accountIds
                    includeUnlinked:(BOOL)includeUnlinked
                 useAvailableAmount:(BOOL)useAvailableAmount
                         completion:(nullable MNFBalancesCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END