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
+ (MNFJob*)fetchRulesWithBudgetId:(NSNumber*)budgetId
                      categoryIds:(nullable NSString*)categoryIds
                        startDate:(nullable NSDate*)startDate
                          endDate:(nullable NSDate*)endDate
            allowOverlappingRules:(nullable NSNumber*)allowOverlappingRules
                       completion:(nullable MNFMultipleBudgetRulesCompletionHandler)completion;

///******************************
/// @name Creating
///******************************
+ (MNFJob*)budgetRuleWithBudgetId:(NSNumber*)budgetId
                      categoryIds:(nullable NSString*)categoryIds
                        startDate:(nullable NSDate*)startDate
                          endDate:(nullable NSDate*)endDate
                   generationType:(nullable NSNumber*)generationType
                    monthInterval:(nullable NSNumber *)monthInterval
                      repeatUntil:(nullable NSDate*)repeatUntil
                       completion:(nullable MNFMultipleBudgetRulesCompletionHandler)completion;

- (MNFJob*)deleteWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;
@end

NS_ASSUME_NONNULL_END
