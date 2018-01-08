//
//  MNFBudget.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 21/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFBudgetEntry.h"
#import "MNFBudgetFilter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFBudget class represents a budget object with serialized json data from the server and methods to interact with the budget api.
 */
@interface MNFBudget : MNFObject

/**
 The type of the budget. 'Planning' or 'Budget'.
*/
@property (nonatomic,copy) NSString * _Nullable type;

/**
 The name of the budget.
 */
@property (nonatomic,copy) NSString * _Nullable name;

/**
 The text description of the budget.
 */
@property (nonatomic,copy) NSString * _Nullable budgetDescription;

/**
 The account ids of the accounts for the budget.
 */
@property (nonatomic,copy) NSArray * _Nullable accountIds;

/**
 The period for the budget if the budget is a planning budget. 'Month.
 */
@property (nonatomic,copy) NSString * _Nullable period;

/**
 The offset of the budget if the budget is a planning budget.
 */
@property (nonatomic,copy) NSString * _Nullable offset;

/**
 The creation date of the budget.
 */
@property (nonatomic,strong) NSDate * _Nullable created;

/**
 The budget entries.
 */
@property (nonatomic,copy) NSArray <MNFBudgetEntry*> * _Nullable entries;

/**
 Fetches a list of budget with a filter.
 
 @param ids The ids of the budgets to return in a comma separated string.
 @param accountIds The account ids to filter budgets by in a comma separated string.
 @param type The type of budget to return in the list.
 @param completion A completion block returning a list of budgets and an error.
 
 @return MNFJob A job containing a list of budgets and an error.
 */
+(MNFJob*)fetchBudgetsWithIds:(nullable NSString *)ids accountIds:(nullable NSString *)accountIds type:(nullable NSString*)type completion:(nullable MNFMultipleBudgetCompletionHandler)completion;

/**
 Fetches a single budget with a given identifier.
 
 @param identifier The identifiter of the budget to fetch.
 @param filter A filter object to filter by the budget entries.
 @param completion A completion block returning a budget and an error.
 
 @return MNFJob A job containing a budget and an error.
 */
+(MNFJob*)fetchBudgetWithId:(NSNumber*)identifier filter:(nullable MNFBudgetFilter*)filter completion:(nullable MNFBudgetCompletionHandler)completion;

/**
 Creates a budget with the given parameters.
 
 @param name The name of the budget.
 @param type The budget type. 'Budget' or 'Planning'.
 @param budgetDescription The text description of the budget.
 @param accountIds The ids of the accounts for the budget.
 @param completion A completion block returning a budget and an error.
 
 @return MNFJob A job containing a budget and an error.
 */
+(MNFJob*)budgetWithName:(nullable NSString*)name
                    type:(nullable NSString*)type
             description:(nullable NSString*)budgetDescription
              accountIds:(nullable NSArray*)accountIds
                  period:(nullable NSString*)period
                  offset:(nullable NSNumber*)offset
              completion:(nullable MNFBudgetCompletionHandler)completion;

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

-(MNFJob*)fetchBudgetEntriesWithFilter:(nullable MNFBudgetFilter*)filter completion:(nullable MNFMultipleBudgetEntriesCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
