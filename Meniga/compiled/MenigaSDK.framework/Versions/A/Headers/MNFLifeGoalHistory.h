//
//  MNFLifeGoalHistory.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/03/2018.
//  Copyright © 2018 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MNFLifeGoalHistory : MNFObject

/**
 The id of the life goal.
 */
@property (nonatomic,strong,readonly) NSNumber *lifeGoalId;

/**
 The time stamp of the change that generated this record.
 */
@property (nonatomic,strong,readonly) NSDate *processingDate;

/**
 The name of the life goal at the time of the change.
 */
@property (nonatomic,copy,readonly) NSString *name;

/**
 The priority of the life goal at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *priority;

/**
 The target date of the life goal at the time of the change.
 */
@property (nonatomic,strong,readonly) NSDate *targetDate;

/**
 The account balance at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *accountBalance;

/**
 The id of the icon for the life goal at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *iconId;

/**
 The intercept amount of the life goal at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *interceptAmount;

/**
 The amount allocated to the life goal at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *currentAmount;

/**
 The estimated recurring amount for the life goal at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *recurringAmount;

/**
 Whether the life goal has been deleted at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *isDeleted;

/**
 Whether the life goal is achieved at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *isAchieved;

/**
 Whether the life goal is withdrawn at the time of the change.
 */
@property (nonatomic,strong,readonly) NSNumber *isWithdrawn;

/**
 The life goal data at the time of the change.
 */
@property (nonatomic,copy,readonly) NSString *lifeGoalData;

@end

NS_ASSUME_NONNULL_END
