//
//  MNFLifeGoal.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 14/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFLifeGoal : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The id of the account connected to this life goal.
 */
@property (nonatomic,strong,readonly) NSNumber *accountId;

/**
 The start date for the life goal.
 */
@property (nonatomic,strong,readonly) NSDate *startDate;

/**
 The calculated expected day of completion, based on currentAmount, recurringAmount and targetAmount.
 */
@property (nonatomic,strong,readonly) NSDate *expectedTargetDate;

/**
 A status enumeration of the life goal. 'OnSchedule', 'Behind', 'Ahead' or 'Achieved'.
 */
@property (nonatomic,copy,readonly) NSString *lifeGoalStatus;

/**
 The date time when this goal was marked as achieved by the user.
 */
@property (nonatomic,strong,readonly) NSDate *achievedDate;

///******************************
/// @name Mutable properties
///******************************

/**
 The name of the life goal.
 */
@property (nonatomic,copy) NSString *name;

/**
 The date for the life goal to be reached by.
 */
@property (nonatomic,strong) NSDate *targetDate;

/**
 The amount to save.
 */
@property (nonatomic,strong) NSNumber *targetAmount;

/**
 The current amount saved.
 */
@property (nonatomic,strong) NSNumber *currentAmount;

/**
 The recurring amount (monthly payment).
 */
@property (nonatomic,strong) NSNumber *recurringAmount;

/**
 The id of the category for this life goal.
 */
@property (nonatomic,strong) NSNumber *categoryId;

/**
 Additional information.
 */
@property (nonatomic,copy) NSString *metadata;

/**
 The recurrence interval type of the life goal. 'Monthly', 'Weekly', 'Daily' or 'Yearly'.
 */
@property (nonatomic,copy) NSString *recurrenceIntervalType;

/**
 Mark this property as reached and save the life goal.
 */
@property (nonatomic,strong) NSNumber *markAsReached;

+(MNFJob*)fetchWithId:(NSNumber*)identifier completion:(nullable MNFLifeGoalCompletionHandler)completion;
+(MNFJob*)fetchLifeGoalsWithCompletion:(nullable MNFMultipleLifeGoalsCompletionHandler)completion;
+(MNFJob*)fetchLifeGoalsAccountInfoWithAccountIds:(nullable NSString *)accountIds completion:(nullable MNFLifeGoalAccountInfoCompletionHandler)completion;
+(MNFJob*)lifeGoalWithName:(nullable NSString*)name
                 accountId:(nullable NSNumber*)accountId
              targetAmount:(nullable NSNumber*)targetAmount
           recurringAmount:(nullable NSNumber*)recurringAmount
             initialAmount:(nullable NSNumber*)initialAmount
                targetDate:(nullable NSDate*)targetDate
                categoryId:(nullable NSNumber*)categoryId
                  metadata:(nullable NSString*)metadata
    recurrenceIntervalType:(nullable NSString*)recurrenceIntervalType
                completion:(nullable MNFLifeGoalCompletionHandler)completion;

-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;
-(MNFJob*)deleteWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;
-(MNFJob*)fetchHistoryWithCompletion:(nullable MNFLifeGoalHistoryCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
