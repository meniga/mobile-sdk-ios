//
//  NSDateUtils.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 19/10/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateUtils : NSObject

+ (BOOL)isDate:(NSDate *)firstDate equalToDateWithAllComponents:(NSDate *)secondDate;
+ (BOOL)isDate:(NSDate *)firstDate equalToDate:(NSDate *)secondDate withDateComponents:(NSCalendarUnit)components;
+ (BOOL)isDate:(NSDate *)firstDate equalToDayMonthAndYear:(NSDate *)secondDate;
+ (NSDateComponents *)allComponentsFromDate:(NSDate *)date;
+ (NSDateFormatter *)dateFormatter;

@end
