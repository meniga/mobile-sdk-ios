//
//  MNFMerchantSeries.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 17/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFMerchantSeriesOptions.h"
#import "MNFObject.h"

@class MNFJob, MNFTransactionFilter;

@interface MNFMerchantSeries : MNFObject

NS_ASSUME_NONNULL_BEGIN

/**
 @description The Id of the corresponding merchant
 **/
@property (nonatomic, readonly) NSNumber *merchantId;

/**
@description The name of the corresponding merchant
**/
@property (nonatomic, readonly) NSString *text;

/**
@description The total amount for the corresponding merchant
**/
@property (nonatomic, readonly) NSNumber *nettoAmount;

/**
 @description The number of transactions for the corresponding merchant with the specified MNFTransactionFilter
 **/
@property (nonatomic, readonly) NSNumber *transactionCount;

/**
 @description Fetches summerized merchant data for the specified transaction filter and options
 **/
+ (nonnull MNFJob *)fetchMerchantSeriesWithTransactionFilter:(nonnull MNFTransactionFilter *)seriesFilter
                                       merchantSeriesOptions:(nonnull MNFMerchantSeriesOptions *)merchantOptions
                                              withCompletion:(nullable MNFMerchantSeriesCompletionHandler)completion;

NS_ASSUME_NONNULL_END

@end
