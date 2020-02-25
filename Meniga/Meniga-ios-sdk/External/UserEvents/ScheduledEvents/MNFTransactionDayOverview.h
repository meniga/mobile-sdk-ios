//
//  MNFTransactionDayOverview.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 6/15/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFTransactionDayOverview : NSObject

/**
 @abstract The date of the transactions for the day.
 */
@property (nonatomic, strong, readonly) NSDate *date;

/**
 @abstract The total income for the day.
 */
@property (nonatomic, strong, readonly) NSNumber *income;

/**
 @abstract The total expenses for the day.
 */
@property (nonatomic, strong, readonly) NSNumber *expenses;

/**
 @abstract The ids of the merchants
 */
@property (nonatomic, strong, readonly) NSArray<NSNumber *> *merchantIds;

/**
 @abstract Expenses listed per categoryId.
 */
@property (nonatomic, strong, readonly) NSDictionary *expensesPerCategory;

/**
 @abstract Income per categoryId.
 */
@property (nonatomic, strong, readonly) NSDictionary *incomePerCategory;

@end
