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
 The MNFBudgetFilter class represents a filter object used to fetch budgets from the server.
 */
@interface MNFBudgetFilter : NSObject <MNFJsonAdapterDelegate>

/**
 The ids of the budgets to filter by.
 */
@property (nonatomic,copy) NSString * _Nullable ids;

/**
 The account ids of the budgets to filter by.
 */
@property (nonatomic,copy) NSString * _Nullable accountIds;

/**
 The category ids of the budgets to filter by.
 */
@property (nonatomic,copy) NSString * _Nullable categoryIds;

/**
 The category types of the budgets to filter by.
 */
@property (nonatomic,copy) NSString * _Nullable categoryType;

/**
 The comma seperated string of names of budgets to filter by.
 */
@property (nonatomic,copy) NSString * _Nullable name;

/**
 The lower limit of target amounts on budgets.
 */
@property (nonatomic,strong) NSNumber * _Nullable targetAmountFrom;

/**
 The upper limit of target amounts on budgets.
 */
@property (nonatomic,strong) NSNumber * _Nullable targetAmountTo;

/**
 The lower limit of spent amouns on budgets.
 */
@property (nonatomic,strong) NSNumber * _Nullable spentAmountFrom;

/**
 The upper limit of spent amounts on budgets.
 */
@property (nonatomic,strong) NSNumber * _Nullable spendAmountTo;

/**
 The starting date of budgets to filter by.
 */
@property (nonatomic,strong) NSDate * _Nullable fromDate;

/**
 The end date of budgets to filter by.
 */
@property (nonatomic,strong) NSDate * _Nullable toDate;

/**
 The text description of budgets to filter by.
 */
@property (nonatomic,copy) NSString * _Nullable budgetDescription;

/**
 Whether to match all account ids to filtered budgets
 */
@property (nonatomic,strong) NSNumber * _Nullable matchAllAccounts;

/**
 Whether to match all category ids to filtered budgets.
 */
@property (nonatomic,strong) NSNumber * _Nullable matchAllCategories;

/**
 Whether budgets with intersecting time periods to the filter time period are returned or only budgets included in the filter period.
 */
@property (nonatomic,strong) NSNumber * _Nullable allowOverlappingDates;

/**
 The id of the parent budget to filter by.
 */
@property (nonatomic,strong) NSNumber * _Nullable parentId;

@end

NS_ASSUME_NONNULL_END
