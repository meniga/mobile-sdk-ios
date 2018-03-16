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

///******************************
/// @name Immutable properties
///******************************

/**
 The type of the budget. 'Planning' or 'Budget'.
*/
@property (nonatomic,copy,readonly) NSString * _Nullable type;

/**
 The period for the budget if the budget is a planning budget. 'Month.
 */
@property (nonatomic,copy,readonly) NSString * _Nullable period;

/**
 The offset of the budget if the budget is a planning budget.
 */
@property (nonatomic,copy,readonly) NSString * _Nullable offset;

/**
 The creation date of the budget.
 */
@property (nonatomic,strong,readonly) NSDate * _Nullable created;

/**
 The budget entries.
 */
@property (nonatomic,copy,readonly) NSArray <MNFBudgetEntry*> * _Nullable entries;

///******************************
/// @name Mutable properties
///******************************

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

///******************************
/// @name Fetching
///******************************

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

///******************************
/// @name Creating
///******************************

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

///******************************
/// @name Fetching entries
///******************************

/**
 Fetches budget entries in the budget.
 
 @param filter A filter object to filter the budget entries.
 @param completion A completion block returning a list of budget entries and an error.
 
 @return MNFJob A job containing a list of entries and an error.
 */
-(MNFJob*)fetchBudgetEntriesWithFilter:(nullable MNFBudgetFilter*)filter completion:(nullable MNFMultipleBudgetEntriesCompletionHandler)completion;

/**
 Fetches a budget entry with a given identifier.
 
 @param identifier The identifier of the budget entry.
 @param completion A completion block returning a budget entry and an error.
 
 @return MNFJob A job containing a budget entry and an error.
 */
- (MNFJob*)fetchBudgetEntryWithId:(NSNumber*)identifier completion:(nullable MNFBudgetEntryCompletionHandler)completion;

///******************************
/// @name Creating entries
///******************************

/**
 Creates budget entries in the budget.
 
 @warning The instances passed to the method as the entries to create are not the same instances returned in the completion block or job.
 
 @param entries A list of budget entries to create.
 @param completion A completion block returning a budget entries and an error.
 
 @return MNFJob A job containing a list of entries and an error.
 */
-(MNFJob*)createBudgetEntries:(NSArray<MNFBudgetEntry*>*)entries completion:(nullable MNFMultipleBudgetEntriesCompletionHandler)completion;

///******************************
/// @name Resetting
///******************************

/**
 Resets the entire budget.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)resetWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
