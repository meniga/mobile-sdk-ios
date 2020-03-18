//
//  MNFUpcomingPattern.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUpcomingPattern class represents a Cron expression that recurring patterns are scheduled from.
 */
@interface MNFUpcomingPattern : MNFObject

///******************************
/// @name Mutable properties
///******************************

/**
 The day-of-month field of the cron expression. If null, the wildcard character * is assumed. Allowed values are null, 1-31.
 */
@property (nonatomic, copy) NSString *_Nullable dayOfMonth;

/**
 The interval field for the day-of-month in the cron expression. Used in conjunction with dayOfMonth. If null, the specified dayOfMonth is assumed. Allowed values are null, 0-N.
 */
@property (nonatomic, strong) NSNumber *_Nullable dayOfMonthInterval;

/**
 The month field of the cron expression. If null, the wildcard character * is assumed Allowed values are null, 1-12.
 */
@property (nonatomic, copy) NSString *_Nullable month;

/**
 The interval field for the month in the cron expression. Used in conjunction with Month. If null, the specified month is assumed Allowed values are null, 0-N.
 */
@property (nonatomic, strong) NSNumber *_Nullable monthInterval;

/**
 The day-of-week field of the cron expression. If null, the wildcard character * is assumed. Allowed values are null, 0-6 where 0 = Sunday = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'].
 */
@property (nonatomic, copy) NSString *_Nullable dayOfWeek;

/**
 The interval field for the day-of-week in the cron expression. Used in conjunction with DayOfWeek. If null, the specified DayOfWeek is assumed Allowed values are null, 0-N.
 */
@property (nonatomic, strong) NSNumber *_Nullable dayOfWeekInterval;

/**
 The week-of-year field of the cron expression. The server will calculate the correct week of year from this field, according to ISO8601 specification. If null, the wildcard character * is assumed Allowed values are null or any valid date value.
 */
@property (nonatomic, strong) NSNumber *_Nullable weekOfYear;

/**
 The interval field for the week-of-year in the cron expression. Used in conjunction with WeekOfYear. If null, the specified WeekOfYear is assumed Allowed values are null, 0-N.
 */
@property (nonatomic, strong) NSNumber *_Nullable weekInterval;

@end

NS_ASSUME_NONNULL_END
