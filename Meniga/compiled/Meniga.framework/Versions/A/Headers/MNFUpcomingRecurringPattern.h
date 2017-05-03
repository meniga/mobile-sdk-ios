//
//  MNFUpcomingRecurringPattern.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@class MNFUpcomingPattern;

/**
 The MNFUpcomingRecurringPattern class containg information on a pattern of recurring transactions.
 */
@interface MNFUpcomingRecurringPattern : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The transaction text for the pattern.
 */
@property (nonatomic,copy,readonly) NSString *text;

/**
 The amount if the upcoming transaction in the currency of 'CurrencyCode'.
 */
@property (nonatomic,strong,readonly) NSNumber *amountInCurrency;

/**
 The ISO 4217 currency code of the recurring transactions.
 */
@property (nonatomic,copy,readonly) NSString *currencyCode;

/**
 The id of the category of the recurring transactions.
 */
@property (nonatomic,strong,readonly) NSNumber *categoryId;

/**
 The id of the account the recurring transactions are expected to be booked from.
 */
@property (nonatomic,strong,readonly) NSNumber *accountId;

/**
 Whether the recurring transactions are to be watched.
 */
@property (nonatomic,strong,readonly) NSNumber *isWatched;

/**
 Whether the recurring transactions are to be flagged.
 */
@property (nonatomic,strong,readonly) NSNumber *isFlagged;

/**
 The recurring type, 'Unknown', 'Detected' or 'Manual'.
 */
@property (nonatomic,copy,readonly) NSString *type;

/**
 The recurring status, 'Unknown', 'Suggested', 'Accepted' or 'Rejected'.
 */
@property (nonatomic,copy,readonly) NSString *status;

///******************************
/// @name Mutable properties
///******************************

/**
 A repeat pattern (Cron expression).
 */
@property (nonatomic) MNFUpcomingPattern *pattern;

/**
 The date when the pattern finishes repeating.
 */
@property (nonatomic,strong) NSDate *repeatUntil;

///******************************
/// @name Fetching
///******************************

/**
 Fetches a recurring pattern with a given identifier.
 
 @param identifier The id of the recurring pattern.
 @param completin A completion block returning a recurring pattern and an error.
 
 @return MNFJob A job containing a recurring pattern and an error.
 */
+(MNFJob*)fetchWithId:(NSNumber*)identifier completion:(MNFRecurringPatternCompletionHandler)completion;

/**
 Fetches a list of recurring patterns that match the given statuses and types.
 
 @param statuses A comma seperated string of recurring statuses ('Unknown','Suggested','Accepted','Rejected'). If nil includes all.
 @param types A comma seperated string of recurring types ('Unknown','Detected','Manual'). If nil includes all.
 @param completion A completion block returning a list of recurring patterns and an error.
 
 @return MNFJob A job containing a list of recurring patterns and an error.
 */
+(MNFJob*)fetchRecurringPatternsWithStatuses:(nullable NSString *)statuses types:(nullable NSString *)types completion:(MNFMultipleRecurringPatternsCompletionHandler)completion;

///******************************
/// @name Deleting
///******************************

/**
 Deletes a recurring pattern from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 
 @note Remember to deallocate objects that have been deleted from the server.
 */
-(MNFJob*)deleteRecurringPatternWithCompletion:(MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END