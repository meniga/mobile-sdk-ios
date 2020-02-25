//
//  MNFFeedItemGroup.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 02/05/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFFeedItem.h"
#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFFeedItemGroup class represents a list of feed items in a feed grouped together by date.
 
 A feed item group is automatically created when performing grouping on a feed.
 */
@interface MNFFeedItemGroup : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The feed items in the group.
 */
@property (nonatomic, copy, readonly) NSArray<MNFFeedItem *> *_Nullable feedItems;

/**
 @abstract The sum of all transactions in the group.
 */
@property (nonatomic, strong, readonly) NSNumber *_Nullable sum;

/**
 @abstract The rule by which the feed items are grouped.
 */
@property (nonatomic, readonly) MNFGroupedBy groupedBy;

/**
 @abstract The date of the group.
 */
@property (nonatomic, strong, readonly) NSDate *_Nullable date;

///******************************
/// @name Initializing
///******************************

/**
 @abstract Initializes a feed item group object with a list of feed items. The list has to be sorted and grouped beforehand.
 
 @param groupedBy The rule by which the feed items are grouped.
 @param feedItems The feed items of the group.
 
 @return An instance of MNFFeedItemGroup.
 */
+ (instancetype)groupBy:(MNFGroupedBy)groupedBy withFeedItems:(NSArray *)feedItems;

@end

NS_ASSUME_NONNULL_END