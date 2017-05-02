//
//  MNFTransactionSeriesFilter.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 22/01/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapterDelegate.h"
#import "MNFTransactionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTransactionSeriesFilter class is used to construct a transaction series request.
 
 A transaction series filter should be directly initialized and used when fetching transaction series.
 */
@interface MNFTransactionSeriesFilter : NSObject <MNFJsonAdapterDelegate>

/**
 @abstract The transaction filter used to filter all transactions into a subset.
 */
@property (nonatomic,strong) MNFTransactionFilter *transactionFilter;

/**
 @abstract The time resolution of the series. (None/Day/Week/Month/Year).
 */
@property (nonatomic,strong) NSString *timeResolution;

/**
 @abstract Whether or not the series should be over time or just a list containing a single object with the whole period aggregated.
 */
@property (nonatomic,strong) NSNumber *overTime;

/**
 @abstract Whether or not the transactions used to create the series should be returned.
 */
@property (nonatomic,strong) NSNumber *includeTransactions;

/**
 @abstract Whether or not the ids of the transactions used to create the series should be returned.
 */
@property (nonatomic,strong) NSNumber *includeTransactionIds;

/**
 @abstract The filters used to select which transactions to use to generate the requested series.
 
 @discussion One filter should be used per series requested. En empty filter returns series for all the transactions in the subset.
 */
@property (nonatomic,strong) NSArray <MNFTransactionFilter*> *seriesSelectors;

@end

NS_ASSUME_NONNULL_END
