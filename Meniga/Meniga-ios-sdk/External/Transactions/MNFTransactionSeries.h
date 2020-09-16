//
//  MNFTransactionSeries.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/01/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

@class MNFTransactionSeriesFilter;
@class MNFTransactionSeriesStatistics;
@class MNFTransactionSeriesValue;
@class MNFTransaction;

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTransactionSeries class encapsulates transaction series json data in an object.
 
 A transaction series should not be directly initialized but fetched from the server. Transaction series represents transaction aggregation.
 */
@interface MNFTransactionSeries : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The time resolution of the series. (None/Day/Week/Month/Year).
 */
@property (nonatomic, copy, readonly) NSString *timeResolution;

/**
 @abstract Statistics for the series over time. Only returned if overTime on the series filter is set to true.
 */
@property (nonatomic, copy, readonly) MNFTransactionSeriesStatistics *statistics;

/**
 @abstract The values for the transaction series.
 */
@property (nonatomic, copy, readonly) NSArray<MNFTransactionSeriesValue *> *values;

/**
 @abstract The transactions used to create the series. Only returned if includeTransactions on the series filter is set to true.
 */
@property (nonatomic, copy, readonly) NSArray<MNFTransaction *> *transactions;

/**
 @abstract The ids of the transactions used to create the series. Only returned if includeTransactionIds on the series filter is set to true.
 */
@property (nonatomic, copy, readonly) NSArray<NSNumber *> *transactionIds;

@property (nonatomic, copy, readonly) NSString *currency;

///******************************
/// @name Fetching
///******************************

/**
 @abstract Fetches a transaction series from the server.
 
 @param seriesFilter The transaction series filter used to create the series.
 @param completion A completion block returning a transaction series and an error.
 
 @return An MNFJob containing a transaction series and an error.
 */
+ (MNFJob *)fetchTransactionSeriesWithTransactionSeriesFilter:(MNFTransactionSeriesFilter *)seriesFilter
                                               withCompletion:
                                                   (nullable MNFTransactionSeriesCompletionHandler)completion;

/**
 @abstract Fetches a transaction series from the server.
 
 @param seriesFilter The transaction series filter used to create the series.
 @param include query parameter that tells which related resources should be included in the response as 'included' data. Supported resources are "Account" and "Merchant", e.g. "Account,Merchant" to get both resources included
 @param completion A completion block returning a transaction series and an error.
 
 @return An MNFJob containing a transaction series and an error.
 */

+ (MNFJob *)fetchTransactionSeriesWithTransactionSeriesFilter:(MNFTransactionSeriesFilter *)seriesFilter
                                                  withInclude:(nullable NSArray *)include
                                                andCompletion:
                                                    (nullable MNFTransactionSeriesCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
