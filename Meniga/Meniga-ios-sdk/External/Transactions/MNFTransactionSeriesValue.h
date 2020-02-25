//
//  MNFTransactionSeriesValue.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/03/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTransactionSeriesValue class represents transaction series values in an object.
 */
@interface MNFTransactionSeriesValue : MNFObject

/**
 The net amount of all the transactions in the period
 */
@property (nonatomic, strong, readonly) NSNumber *nettoAmount;

/**
 The total positive amount of all the transactions in the period.
 */
@property (nonatomic, strong, readonly) NSNumber *totalPositive;

/**
 The total negative amount of all the transactions in the period.
 */
@property (nonatomic, strong, readonly) NSNumber *totalNegative;

/**
 The start date of the period.
 */
@property (nonatomic, strong, readonly) NSDate *date;

/**
 The transaction ids of all the transactions in the period.
 */
@property (nonatomic, strong, readonly) NSArray<NSNumber *> *transactionIds;

@end

NS_ASSUME_NONNULL_END
