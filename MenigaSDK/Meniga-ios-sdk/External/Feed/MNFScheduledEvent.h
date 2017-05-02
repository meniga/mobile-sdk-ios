//
//  MNFScheduledEvent.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 6/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFObject.h"

@class MNFTransactionDayOverview;

typedef NS_ENUM(NSInteger, MNFScheduleInterval) {
    Weekly,
    Monthly
};

@interface MNFScheduledEvent : MNFObject

/**
 @abstract The total expense of the period of the scheduled event.
 */
@property (nonatomic, strong, readonly) NSNumber *totalExpenses;

/**
 @abstract The total income of the the period of the scheduled event.
 */
@property (nonatomic, strong, readonly) NSNumber *totalIncome;

/**
 @abstract The total expense per category id over the scheduled event period.
 */
@property (nonatomic, strong, readonly) NSDictionary *expensesPerCategory;

/**
 @abstract The total income per category id over the scheduled event period.
 */
@property (nonatomic, strong, readonly) NSDictionary *incomePerCategory;

/**
 @abstract The number of transactions per merchant id.
 */
@property (nonatomic, strong, readonly) NSDictionary *transactionCountPerMerchant;

/**
 @abstract A string describing whether it's a 'Weekly' or 'Monthly' scheduled event. Other types may be introduced with time.
 */
@property (nonatomic, strong, readonly) NSString *scheduledEventType;

/**
 @abstract The start date of the scheduled event.
 */
@property (nonatomic, strong, readonly) NSDate *startDate;

/**
 @abstract The end date of the scheduled event.
 */
@property (nonatomic, strong, readonly) NSDate *endDate;

/**
 @abstract A list of transactions per day over the scheduled period with additional data about each day that can be presented to the user in various forms. Look at MNFTransactionDayOverview object for more information about its properties.
 */
@property (nonatomic, strong, readonly) NSArray <MNFTransactionDayOverview *> *transactionsPerDay;

/**
 @abstract The topic id of the scheduled event.
 */
@property (nonatomic, strong, readonly) NSNumber *topicId;

/**
 @abstract The date the scheduled event was generated on.
 */
@property (nonatomic, strong, readonly) NSDate *date;

/**
 @abstract The name of the topic this scheduled event relates to. Example would be "info" or "transaction".
 */
@property (nonatomic, strong, readonly) NSString *topicName;

/**
 @abstract The title of the event such as weekly report.
 */
@property (nonatomic, strong, readonly) NSString *title;

/**
 @acstract The body of the event.
 */
@property (nonatomic, strong, readonly) NSString *body;

/**
 @abstract The type name should always be ScheduledFeedItemModel.
 */
@property (nonatomic, strong, readonly) NSString *typeName;

+ (MNFJob*)fetchWithId:(NSNumber *)identifier completion:(nullable MNFScheduledEventCompletionHandler)completion;

- (MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end
