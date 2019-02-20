//
//  MNFBudgetEntry.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 18/12/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFBudgetEntry class represents a single budget entry.
 */
@interface MNFBudgetEntry : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The date and time the entry was last edited.
 */
@property (nonatomic,strong,readonly) NSDate * _Nullable updatedAt;

/**
 The id of the budget the entry is in.
 */
@property (nonatomic,strong,readonly) NSNumber * _Nullable budgetId;

/**
 The generation type for the entry if iti is in a planning budget.
 */
@property (nonatomic,strong,readonly) NSNumber * _Nullable generationType;

/**
 The spent amount in the associated categories if the entry is current.
 */
@property (nonatomic,strong,readonly) NSNumber * _Nullable spentAmount;

/**
 The id of the associated rule.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable ruleId;

/**
 The number of transactions.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable transactionCount;

///******************************
/// @name Mutable properties
///******************************

/**
 The target amount for the budget entry.
 */
@property (nonatomic,strong) NSNumber * _Nullable targetAmount;

/**
 The start date for the budget entry.
 */
@property (nonatomic,strong) NSDate * _Nullable startDate;

/**
 The end date for the budget entry.
 */
@property (nonatomic,strong) NSDate * _Nullable endDate;

/**
 The category ids associated with the budget entry.
 */
@property (nonatomic,copy) NSArray <NSNumber*> * _Nullable categoryIds;

///******************************
/// @name Saving
///******************************

/**
 Saves changes to a budget.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Deleting
///******************************

/**
 Deletes a budget.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)deleteWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Refreshing
///******************************

/**
 Refreshes a budget.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
