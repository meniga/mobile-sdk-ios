//
//  MNFBudget.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 21/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@class MNFBudgetFilter;

/**
 The MNFBudget class represents a budget object with serialized json data from the server and methods to interact with the budget api.
 */
@interface MNFBudget : MNFObject

/**
 The name of the budget.
 */
@property (nonatomic,copy) NSString * _Nullable name;

/**
 The target spending amount of the budget.
 */
@property (nonatomic,strong) NSNumber * _Nullable targetAmount;

/**
 The current spent amount of the budget.
 */
@property (nonatomic,strong,readonly) NSNumber * _Nullable spentAmount;

/**
 The date the budget is valid from.
 */
@property (nonatomic,strong) NSDate * _Nullable validFrom;

/**
 The date the budget is valid to.
 */
@property (nonatomic,strong) NSDate * _Nullable validTo;

/**
 The date the budget was updated. Nil if the budget has never been updated.
 */
@property (nonatomic,strong,readonly) NSDate * _Nullable updatedAt;

/**
 The text description of the budget.
 */
@property (nonatomic,strong) NSString * _Nullable budgetDescription;

/**
 The category ids of the categories for the budget.
 */
@property (nonatomic,copy) NSArray * _Nullable categoryIds;

/**
 The account ids of the accounts for the budget.
 */
@property (nonatomic,copy) NSArray * _Nullable accountIds;

/**
 The id of the parent of the budget.
 */
@property (nonatomic,strong,readonly) NSNumber * _Nullable parentId;

/**
 Fetches a list of budget with a filter.
 
 @param filter An MNFBudgetFilter object used to filter budgets.
 @param completion A completion block returning a list of budgets and an error.
 
 @return MNFJob A job containing a list of budgets and an error.
 */
+(MNFJob*)fetchBudgetsWithFilter:(nullable MNFBudgetFilter*)filter completion:(nullable MNFMultipleBudgetCompletionHandler)completion;

/**
 Fetches a single budget with a given identifier.
 
 @param identifier The identifiter of the budget to fetch.
 @param completion A completion block returning a budget and an error.
 
 @return MNFJob A job containing a budget and an error.
 */
+(MNFJob*)fetchBudgetWithId:(NSNumber*)identifier completion:(nullable MNFBudgetCompletionHandler)completion;

/**
 Creates a budget with the given parameters.
 
 @param name The name of the budget.
 @param targetAmount The target spending amount of the budget.
 @param validFrom The date the budget is valid from.
 @param validTo The date the budget is valid to.
 @param budgetDescription The text description of the budget.
 @param allCategoriesType The category type for the budget. 'Expenses', 'Income', 'Savings', 'Excldued'. If set will override the category ids parameter.
 @param categoryIds The ids of the categories for the budget.
 @param accountIds The ids of the accounts for the budget.
 @param completion A completion block returning a budget and an error.
 
 @return MNFJob A job containing a budget and an error.
 */
+(MNFJob*)budgetWithName:(nullable NSString*)name
            targetAmount:(nullable NSNumber*)targetAmount
               validFrom:(nullable NSDate*)validFrom
                 validTo:(nullable NSDate*)validTo
             description:(nullable NSString*)budgetDescription
     allCategoriesOfType:(nullable NSString*)allCategoriesType
             categoryIds:(nullable NSArray*)categoryIds
              accountIds:(nullable NSArray*)accountIds
              completion:(nullable MNFBudgetCompletionHandler)completion;

/**
 Recalculates the spent amount in all the budgets that match a given filter.
 
 @param filter An MNFBudgetFilter object to filter by.
 @param completion A completion block returning a list of budgets and an error.
 
 @return MNFJob A job containing a list of budgets and an error.
 */
+(MNFJob*)recalculateWithFilter:(MNFBudgetFilter*)filter completion:(nullable MNFMultipleBudgetCompletionHandler)completion;

/**
 Deletes a list of budgets.
 
 @param budgets The budgets to delete.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+(MNFJob*)deleteBudgets:(NSArray <MNFBudget*> *)budgets withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Deletes all budgets with a parent id.
 
 @param parentId The parend id of the budgets to delete.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+(MNFJob*)deleteWithParentId:(NSNumber *)parentId completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Creates a budget that repeats at a specified interval.
 
 @param name The name of the budget.
 @param targetAmount The target spending amount of the budget.
 @param validFrom The date the budget is valid from.
 @param validTo The date the budget is valid to.
 @param budgetDescription The text description of the budget.
 @param allCategoriesType The category type for the budget. 'Expenses', 'Income', 'Savings', 'Excldued'. If set will override the category ids parameter.
 @param categoryIds The ids of the categories for the budget.
 @param accountIds The ids of the accounts for the budget.
 @param numberOfRecurrences How often the budget should repeat.
 @param interval A number describing how many interval types should be between recurrences.
 @param intervalType The interval type. 'Day', 'Week' or 'Month'.
 @param completion A completion block returning a list of budgets and an error.
 
 @return MNFJob A job containing a list of budgets and an error.
 */
+(MNFJob*)recurringBudgetWithName:(nullable NSString*)name
                     targetAmount:(nullable NSNumber*)targetAmount
                        validFrom:(nullable NSDate*)validFrom
                          validTo:(nullable NSDate*)validTo
                      description:(nullable NSString*)budgetDescription
              allCategoriesOfType:(nullable NSString*)allCategoriesType
                      categoryIds:(nullable NSArray*)categoryIds
                       accountIds:(nullable NSArray*)accountIds
              numberOfRecurrences:(NSNumber*)numberOfRecurrences
                         interval:(NSNumber*)interval
                     intervalType:(NSString*)intervalType
                       completion:(nullable MNFMultipleBudgetCompletionHandler)completion;

/**
 Saves changes to a budget.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Deletes a budget.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)deleteWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Refreshes a budget.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Fetches a list of transactions the budget is calculated from.
 
 @param completion A completion block returning a list of transactions and an error.
 
 @return MNFJob A job containing a list of transactions and an error.
 */
-(MNFJob*)fetchTransactionsWithCompletion:(nullable MNFMultipleTransactionsCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
