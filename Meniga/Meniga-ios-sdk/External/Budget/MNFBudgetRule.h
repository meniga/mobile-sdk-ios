//
//  MNFBudgetRule.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 27/11/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFBudgetRule : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The target amount in the planning rule.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable targetAmount;

/**
 The start date for the rule.
 */
@property (nonatomic,strong,readonly) NSDate *_Nullable startDate;

/**
 The end date for the rule.
 */
@property (nonatomic,strong,readonly) NSDate *_Nullable endDate;

/**
 The date and time the rule was last edited.
 */
@property (nonatomic,strong,readonly) NSDate *_Nullable updatedAt;

/**
 The id of the budget the rule is in.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable budgetId;

/**
 The generation type for the rule.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable generationType;

/**
 The category ids the rule is associated with.
 */
@property (nonatomic,copy,readonly) NSArray <NSNumber*> *_Nullable categoryIds;

///******************************
/// @name Fetching
///******************************

/**
 Fetches a list of budget rules.
 
 @param budgetId The id of the budget the rules are in.
 @param categoryIds The category ids the rules are associated with.
 @param startDate The start date for the rules.
 @param endDate The end date for the rules.
 @param allowOverlappingRules Whether rules can overlap the start and end date parameters.
 @param completion A completion block returning a list of budget rules and an error.
 
 @return MNFJob A job containing a list of budget rules and an error.
 */
+ (MNFJob*)fetchRulesWithBudgetId:(NSNumber*)budgetId
                      categoryIds:(nullable NSString*)categoryIds
                        startDate:(nullable NSDate*)startDate
                          endDate:(nullable NSDate*)endDate
            allowOverlappingRules:(nullable NSNumber*)allowOverlappingRules
                       completion:(nullable MNFMultipleBudgetRulesCompletionHandler)completion;

///******************************
/// @name Creating
///******************************

/**
 Creates a list of budget rules.
 
 @param budgetId The id of the budget the rules are in.
 @param categoryIds The category ids the rules are associated with.
 @param startDate The start date for the rules.
 @param endDate The end date for the rules.
 @param generationType The generation type for the rules.
 @param monthInterval The monthly interval of a recurring pattern for the rules.
 @param repeatUntil The end of the recurrence of the rules.
 @param completion A completion block returning a list of budget rules and an error.
 
 @return MNFJob A job containing a list of budget rules and an error.
 */
+ (MNFJob*)budgetRuleWithBudgetId:(NSNumber*)budgetId
                      categoryIds:(nullable NSString*)categoryIds
                        startDate:(nullable NSDate*)startDate
                          endDate:(nullable NSDate*)endDate
                   generationType:(nullable NSNumber*)generationType
                    monthInterval:(nullable NSNumber *)monthInterval
                      repeatUntil:(nullable NSDate*)repeatUntil
                       completion:(nullable MNFMultipleBudgetRulesCompletionHandler)completion;

///******************************
/// @name Deleting
///******************************

/**
 Deletes a budget rule.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
- (MNFJob*)deleteWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;
@end

NS_ASSUME_NONNULL_END
