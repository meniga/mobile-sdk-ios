//
//  MNFFeed.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

#import "MNFFeedItem.h"
#import "MNFFeedItemGroup.h"
#import "MNFScheduledEvent.h"
#import "MNFTransactionDayOverview.h"
#import "MNFUserEvent.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFFeed class encapsulates the user feed json data in an object.
 
 A feed should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFFeed object. */
@interface MNFFeed : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract A list of feed items.
 
 @discussion Each feed item represents a list of transactions on the same date.
 */
@property (nonatomic,strong,readonly) NSArray <MNFFeedItem *> *_Nullable feedItems;

/**
 @abstract Whether the server feed has more data to be fetched.
 */
@property (nonatomic,readonly) BOOL hasMoreData;
/**
 @abstract The starting date of the feed.
 */
@property (nonatomic,strong,readonly) NSDate *from;

/**
 @abstract The final date of the feed.
 */
@property (nonatomic,strong,readonly) NSDate *to;

/**
 @abstract If not all items were returned within the specified time range, this field will indicate the date of the last returned item. Else it will be nil. This could happen either if a take value has been passed or the backend hard limit have been reached.
 */
@property (nonatomic,strong,readonly) NSDate *actualEndDate;

/**
 @abstract Indicates whether there exists more pages when paginating.
 */
@property (nonatomic,readonly) BOOL hasMorePages;

/**
 @abstract Use this value to explicitly state which feed items you would like to show in you. Make the value nil in order to display all topic ids. Defaults to nil.
 */
@property (nonatomic, strong, nullable) NSArray <NSString *> *topicNamesToDisplay;


///******************************
/// @name Pagination
///******************************

/**
 @description Adds the next page of feedItems to the feedItems of the feed object.
 
 @return An MNFJob containing an error or nil.
 @warning Should only be used if take has been used when fetching the feed object
 */
-(MNFJob*)appendPageWithCompletion:(MNFFeedItemsCompletionHandler)completion;

/**
 @description Replaces the existing feedItems in the feed object with the next page of feed items.
 
 @return An MNFJob containing an error or nil.
 */
-(MNFJob*)nextPageWithCompletion:(void (^)(NSError  * _Nullable error))completion;

/**
 @description Replaces the existing feedItems in the feed object with the previous page of feed items.
 
 @return An MNFJob containing an error or nil.
 */
-(MNFJob*)prevPageWithCompletion:(void (^)(NSError * _Nullable error))completion;

///******************************
/// @name Fetching
///******************************

/**
 @description Fetches the user feed from the server between two dates.
 
 @param from The date from which the feed is to be fetched.
 @param to The date to which the feed is to be fetched.
 @param skip The number of feed items to skip. If nil then no feed items are skipped.
 @param take The number of feed items to take. If nil then all items are returned.
 @param completion A completion block returning a feed and an error.
 
 @return An MNFJob containing an MNFFeed or an error.
 */
+(MNFJob*)fetchFromDate:(NSDate *)from toDate:(NSDate *)to skip:(nullable NSNumber *)skip take:(nullable NSNumber *)take withCompletion:(nullable MNFFeedCompletionHandler)completion;

///******************************
/// @name Appending
///******************************

/**
 @abstract Appends days to the back of the feed.
 
 @param days The number of days to append to the feed.
 @param completion A completion block returning an error.
 
 @return An MNFJob containing the server result or an error.
 */
-(MNFJob*)appendDays:(NSNumber*)days withCompletion:(nullable MNFFeedItemsCompletionHandler)completion;

///******************************
/// @name Refresh
///******************************

/**
 @abstract Replaces the feed data with feed data from the server.
 
 @param from The date from which feed data is to be fetched.
 @param to The date to which feed data is to be fetched.
 @param completion A completion block returning an error.
 
 @return An MNFJob containing the server results or an error.
 */
-(MNFJob*)refreshFromServerFromDate:(NSDate*)from toDate:(NSDate*)to withCompletion:(nullable void (^)(NSArray <MNFFeedItem *> *refreshedObjects, NSArray <MNFFeedItem *> *itemsToReplace, NSError *error))completion;

///******************************
/// @name Fetch feed types
///******************************

/**
 @abstract Fetches all the available feed types as an array of strings.
 
 @param completion A completion block returning an array of strings and an error.
 
 @return An MNFJob containing an array of strings and an error.
 */
+(MNFJob*)fetchFeedTypesWithCompletion:(nullable MNFFeedTypesCompletionHandler)completion;

///******************************
/// @name Grouping
///******************************

/**
 @abstract Groups all feed items by date into feed item groups.
 */
-(void)groupByDate;

/**
 @abstract Ungroups feed item groups back into a list of feed items.
 */
-(void)ungroup;

@end

NS_ASSUME_NONNULL_END
