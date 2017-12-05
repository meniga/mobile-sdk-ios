//
//  MNFUpcomingBalanceDate.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUpcomingBalanceDate class containg information on projected balance entries when fetching upcoming balance.
 */
@interface MNFUpcomingBalanceDate : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The date of a specific entry.
 */
@property (nonatomic,strong,readonly) NSDate *date;

/**
 The balance at the end of the day.
 */
@property (nonatomic,strong,readonly) NSNumber *endOfDayBalance;

/**
 The upcoming income total for that day.
 */
@property (nonatomic,strong,readonly) NSNumber *income;

/**
 The upcoming expenses for that day.
 */
@property (nonatomic,strong,readonly) NSNumber *expenses;

@end

NS_ASSUME_NONNULL_END