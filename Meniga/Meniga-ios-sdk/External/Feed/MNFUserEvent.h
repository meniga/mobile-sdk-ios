//
//  MNFUserEvent.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUserEvent class encapsulates user event json data from the server in an object.
 
 A user event should not be directly initialized. It is created by fetching a user feed using MNFFeed.
 A user event will be created as part of a feed data.
 */
@interface MNFUserEvent : MNFObject

// MARK: New User Event properties

/**
 @abstract The text that species the action on the object
 */
@property (nonatomic, strong, readonly) NSString *actionText;

/**
 @abstract The body of the user event which is displayed to the user. For example for a transaction user event: "This is your first transaction here".
 */
@property (nonatomic, strong, readonly) NSString *body;

/**
 @abstract The channel identifier the user event belongs to.
 */
@property (nonatomic, strong, readonly) NSNumber *channelId;

/**
 @abstract The display color of the user event.
 */
@property (nonatomic, strong, readonly) NSString *displayColor;

/**
 @abstract The display icon identifier.
 */
@property (nonatomic, strong, readonly) NSNumber *displayIconIdentifier;

/**
 @abstract Event type identifier.
 */
@property (nonatomic, strong, readonly) NSString *eventTypeIdentifier;

/**
 @abstract Should exclude the event.
 */
@property (nonatomic, strong, readonly) NSNumber *exclude;

/**
 @abstract Whether the user event is dynamically generated.
 */
@property (nonatomic, strong, readonly) NSNumber *isDynamic;

/**
 @abstract Whether the user event is grouped.
 */
@property (nonatomic, strong, readonly) NSNumber *isGrouped;

/**
 @abstract The segment the generated user event belongs to if he belongs to a specific segment.
 */
@property (nonatomic, strong, readonly, nullable) NSNumber *segmentId;

@property (nonatomic, strong, readonly, nullable) NSNumber *templateId;

/**
 @abstract The title of the user event.
 */
@property (nonatomic, strong, readonly) NSString *title;

/**
 @abstract A list of topic ids that are connected to the user events. The value is based on the type i.e. for transactions topic id would contain a transaction id 
 */
@property (nonatomic, strong, readonly) NSArray *topicId;

/**
 @abstract The date of the user event.
 */
@property (nonatomic, strong, readonly) NSDate *date;

/**
 @abstract The name of the topic the user event relates to.
 */
@property (nonatomic, strong, readonly) NSString *topicName;

/**
 @absttract The type of feed item you are working with.
 */
@property (nonatomic, strong, readonly) NSString *typeName;

/**
 @abstract The data for the given user event.
 */
@property (nonatomic, strong, readonly) NSDictionary *userEventData;

/**
 @abstract User event type id
 */
@property (nonatomic, strong, readonly) NSNumber *userEventTypeId;

/**
 @abstract The user id the given feed it em is for.
 */
@property (nonatomic, strong, readonly) NSNumber *userId;

@property (nonatomic, strong, readonly) NSDictionary *messageData;

@property (nonatomic,strong,readonly) NSDictionary *dataItem;

/**
 Subscribe to a list of user events on a given channel.
 
 @param userEventTypeIdentifiers A list of string constants representing the user events to subscribe to. The available userEventTypeIdentifiers can be fetched through 'fetchEventTypesWithCompletion:'.
 @param channelName The channel through which the user events are deliverd. The available channels are 'ActivityFeedMobile','Email' and 'Push'.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+ (MNFJob *)subscribeToUserEvents:(NSArray <NSString *> *)userEventTypeIdentifiers onChannel:(NSString *)channelName withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Unsubscribe from a list of user events on a given channel.
 
 @param userEventTypeIdentifiers A list of string constants representing the user events to subscribe to. The available userEventTypeIdentifiers can be fetched through 'fetchEventTypesWithCompletion:'.
 @param channelName The channel through which the user events are deliverd. The available channels are 'ActivityFeedMobile','Email' and 'Push'.
 @param unsubscriptionReason The reason why you are unsubscribing.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+ (MNFJob *)unsubscribeFromUserEvents:(NSArray <NSString *> *)userEventTypeIdentifiers onChannel:(NSString *)channelName withReason:(nullable NSString *)unsubscriptionReason completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Fetch a list of all feed event type identifiers.
 
 @param completion A completion block returning a list of event types and an error.
 
 @return MNFJob A job containing a list of event types and an error.
 */
+ (MNFJob *)fetchEventTypesWithCompletion:(nullable void (^)(NSArray <NSString *> *_Nullable eventTypes, NSError *_Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
