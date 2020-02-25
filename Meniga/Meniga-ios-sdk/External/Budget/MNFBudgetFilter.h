//
//  MNFBudgetFilter.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 21/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapterDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFBudgetFilter class represents a filter object used to fetch budgets filterd by budget entries from the server.
 */
@interface MNFBudgetFilter : NSObject <MNFJsonAdapterDelegate>

/**
 The category ids of the budgets to filter by.
 */
@property (nonatomic, copy) NSString *_Nullable categoryIds;

/**
 The start date (inclusive) to return entries from.
 */
@property (nonatomic, strong) NSDate *_Nullable startDate;

/**
 The end date (inclusive) to return entries to.
 */
@property (nonatomic, strong) NSDate *_Nullable endDate;

/**
 Whether budget entries with intersecting time periods to the filter time period are returned or only budget entries included in the filter period.
 */
@property (nonatomic, strong) NSNumber *_Nullable allowOverlappingEntries;

/**
 Whether to include entries with the budget object.
 */
@property (nonatomic, strong) NSNumber *_Nullable includeEntries;

/**
 Whether to include target amounts, generation types and id's also for past entries if applicable.
 */
@property (nonatomic, strong) NSNumber *_Nullable includeOptionalHistoricalData;

/**
 Whether budget entries with intersecting time periods to the filter time period are returned or only budget entries included in the filter period.
 */
@property (nonatomic, strong) NSNumber *_Nullable allowOverlappingDates DEPRECATED_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
