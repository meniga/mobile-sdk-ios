//
//  MNFTransactionSeriesStatistics.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/03/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTransactionSeriesStatistics class represents transaction series statistics data as an object.
 */
@interface MNFTransactionSeriesStatistics : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The current month total amount for this series.
 */
@property (nonatomic, strong, readonly) NSNumber *currentMonthTotal;

/**
 The total amount for this series.
 */
@property (nonatomic, strong, readonly) NSNumber *total;

/**
 The average amount for each value in this series.
 */
@property (nonatomic, strong, readonly) NSNumber *average;

/**
The total Amount for the whole transaction series. Nonzero only when IncludeTotalsInCurrency is true.
 */
@property (nonatomic, copy, readonly) NSNumber *totalInCurrency;

/**
The average amount of the transaction series. Nonzero only when IncludeTotalsInCurrency is true.
 */
@property (nonatomic, copy, readonly) NSNumber *averageInCurrency;

@end

NS_ASSUME_NONNULL_END
