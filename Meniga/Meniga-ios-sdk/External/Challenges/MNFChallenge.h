//
//  MNFChallenge.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 15/11/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFChallenge class represents a challenge.
 */
@interface MNFChallenge : MNFObject

///******************************
/// @name Immutable properties
///******************************

@property (nonatomic,strong,readonly) NSString *_Nullable challengeId;

/**
 Whether the challenge has been accepted.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable accepted;

/**
 The date the challenge was accepted. Nil if the challenge has not been accepted.
 */
@property (nonatomic,strong,readonly) NSDate *_Nullable acceptedDate;

/**
 The topic id of the challenge.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable topicId;

/**
 The type of the challenge. 'Meter', 'Spending, 'Savings' or 'Custom'.
 */
@property (nonatomic,copy,readonly) NSString *_Nullable type;

/**
 The model for the challenge
 */
@property (nonatomic,strong,readonly) NSObject <MNFJsonAdapterDelegate> *_Nullable challengeModel;

@property (nonatomic,strong,readonly) NSNumber *_Nullable enabled;

///******************************
/// @name Mutable properties
///******************************

/**
 The title of the challenge.
 
 @warning This property is only mutable for type 'CustomSpending.
 */
@property (nonatomic,copy) NSString *_Nullable title;

/**
 The text description of the challenge.
 
 @warning This property is only mutable for type 'CustomSpending.
 */
@property (nonatomic,copy) NSString *_Nullable challengeDescription;

/**
 The start date of the challenge.
 
 @warning This property is only mutable for type 'CustomSpending.
 */
@property (nonatomic,strong) NSDate *_Nullable startDate;

/**
 The end date of the challenge
 
 @warning This property is only mutable for type 'CustomSpending.
 */
@property (nonatomic,strong) NSDate *_Nullable endDate;

/**
 The url of the icon to display with this challenge.
 
 @warning This property is only mutable for type 'CustomSpending.
 */
@property (nonatomic,strong) NSString *_Nullable iconUrl;

/**
 Fetches a challenge with a given identifier.
 
 @param identifier The identifier of the challenge.
 @param completion A completion block returning a challenge and an error.
 
 @return MNFJob A job containing a list of challenges or an error.
 */
+(MNFJob*)fetchChallengeWithId:(NSNumber *)identifier completion:(nullable MNFChallengesCompletionHandler)completion;

/**
 Fetches challenges, optionally including only accepted and/or expired challenges.
 
 @param includeExpired Whether to include expired challenges or not. If nil fetches all challenges.
 @param completion A completion block returning a list of challenges and an error.
 
 @return MNFJob A job containing a list of challenges or an error.
 */
+(MNFJob*)fetchChallengesWithIncludeExpired:(nullable NSNumber*)includeExpired excludeSuggested:(nullable NSNumber*)excludeSuggested excludeAccepted:(nullable NSNumber*)excludeAccepted includeDisable:(nullable NSNumber*)includeDisabled completion:(nullable MNFMultipleChallengesCompletionHandler)completion;

/**
 Fetches a list of previously completed recurring system challenges. When a recurring suggested challenge is accepted a copy of it is created in the system. When fetching challenges you will only see the current recurring challenge. In order to see previously accepted and completed copies of that challenge you should use this method to retrieve them.
 
 @param skip The number of items to skip. Defaults to zero.
 @param take The number of items to fetch. Defaults to all items.
 @param completion A completion block returning a list of challenges and an error.
 
 @return MNFJob A job containing a list of challenges and an error.
 */
-(MNFJob*)fetchChallengeHistoryWithSkip:(nullable NSNumber*)skip take:(nullable NSNumber*)take completion:(nullable MNFMultipleChallengesCompletionHandler)completion;

/**
 Accepts a challenge.
 
 @param targetAmount The target amount for the challenge.
 @param waitTime The time in milliseconds to wait while the server completes calculating the parameters of the challenge.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)acceptChallengeWithTargetAmount:(nullable NSNumber*)targetAmount waitTime:(nullable NSNumber*)waitTime completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Saves changes made to the challenge to the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Deletes a challenge from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 
 @warning The challenge must have been accepted by the user.
 */
-(MNFJob*)deleteWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Refreshes a challenge with data from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Resumes a previously enabled challenge.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)enableWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Pauses a previously accepted challenge. For suggested challenges not accepted yet an acceptance is made but in disabled state. Disabled challenges can be re-enabled by using the enable endpoint.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)disableWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Create a new challenge.
 
 @param title The title of the challenge.
 @param description The text description of the challenge.
 @param startDate The starting date of the challenge.
 @param endDate The end date of the challenge.
 @param iconUrl The icon url to display with this challenge.
 @param typeData The typeData for the challenge.
 @param completion A completion block returning a challenge and an error.
 
 @return MNFJob A job containing a challenge and an error.
 */
+(MNFJob*)challengeWithTitle:(nullable NSString*)title
                 description:(nullable NSString*)description
                   startDate:(nullable NSDate*)startDate
                     endDate:(nullable NSDate*)endDate
                     iconUrl:(nullable NSString*)iconUrl
                    typeData:(nullable NSDictionary*)typeData
                  completion:(nullable MNFChallengesCompletionHandler)completion;

/**
 Fetch a list of icon identifiers used to fetch icon image data.
 
 @param format The format for the icons, 'png' or 'svg'. If nil returns both.
 @param completion A completion block returning a list of strings and an error.
 
 @return MNFJob A job containing a list of strings and an error.
 */
+(MNFJob*)fetchIconIdentifiersWithFormat:(nullable NSString*)format completion:(nullable MNFChallengeIconIdentifiersCompletionHandler)completion;

/**
 Fetch a challenge icon resource with a give identifier.
 
 @param iconIdentifier The identifier of the icon to fetch.
 @param completion A completion block returning image data and an error.
 
 @return MNFJob A job containing image data and an error.
 */
+(MNFJob*)fetchIconWithIdentifier:(NSString *)iconIdentifier completion:(nullable MNFChallengeIconImageDataCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
