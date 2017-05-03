//
//  MNFUser.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

#import "MNFRealmUser.h"
#import "MNFUserProfile.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUser object encapsulates a user profile json data from the server in an object.
 
 A user should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFUser object.
 */
@interface MNFUser : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The identifier of the person corresponding to this user.
 */
@property (nonatomic,strong,readonly) NSNumber *personId;

/**
 @abstract The preferred culture set for this person.
 */
@property (nonatomic,copy,readonly) NSString *culture;

/**
 @abstract The date this person last logged in.
 */
@property (nonatomic,strong,readonly) NSDate *lastLoginDate;

/**
 @abstract Whether initial setup has been completed for this user.
 */
@property (nonatomic,strong,readonly) NSNumber *isInitialSetupDone;

/**
 @abstract The email for this person.
 */
@property (nonatomic,copy,readonly) NSString *email;

/**
 @abstract The host where this person last logged in.
 */
@property (nonatomic,copy,readonly) NSString *lastLoginRemoteHost;

/**
 @abstract The date this person was created.
 */
@property (nonatomic,strong,readonly) NSDate *createDate;

/**
 @abstract The id of the terms and condition this person has accepted.
 */
@property (nonatomic,strong,readonly) NSNumber *termsAndConditionsId;

/**
 @abstract The date this person acceted the terms and conditions.
 */
@property (nonatomic,strong,readonly) NSDate *termsAndConditionsAcceptDate;

/**
 @abstract The date this perosn opted out of the system.
 */
@property (nonatomic,strong,readonly) NSDate *optOutDate;

/**
 @abstract The users profile.
 */
@property (nonatomic,strong,readonly) MNFUserProfile *profile;

/**
 @abstract The phone number for this person.
 */
@property (nonatomic,copy,readonly) NSString *phoneNumber;

/**
 @abstract The date when the users password is set to expire.
 */
@property (nonatomic,strong,readonly) NSDate *passwordExpiryDate;

/**
 @abstract Whether the user should be hidden from search results in admin.
 */
@property (nonatomic,strong,readonly) NSNumber *hide;

///******************************
/// @name Mutable properties
///******************************

/**
 @abstract Optional display first name for the current person.
 */
@property (nonatomic,strong) NSString *_Nullable firstName;

/**
 @abstract Option display surname for the current person.
 */
@property (nonatomic,strong) NSString *_Nullable lastName;

///******************************
/// @name Fetching
///******************************

/**
 @abstract Fetches a list of all persons connected to the given user.
 
 @param completion A completion block returning a list of persons and an error.
 
 @return An MNFJob containing a list of persons and an error.
 */
+(MNFJob*)fetchUsersWithCompletion:(nullable MNFMultipleUsersCompletionHandler)completion;

///******************************
/// @name Saving
///******************************

/**
 @abstract Saves changes to this person.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Deleting
///******************************

/**
 @abstract Deletes the current person.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)deleteUserWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Refreshing
///******************************

/**
 @abstract Refreshes the current person with server data.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Culture
///******************************

/**
 @abstract Changes the culture for the current person.
 
 @param culture The culture to be set.
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)changeCulture:(NSString*)culture withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Opting
///******************************

/**
 @abstract Opts in the current person.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)optInWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Opts out the current person.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)optOutWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Metadata
///******************************

/**
 @abstract Fetches user metadata based on the names provided. By default it returns all user metadata for the current user.
 
 @param keys The keys of the metadata to be fetched in a comma seperated string.
 @param completion A completion block returning a list of NSDictionary of metadata and an error.
 
 @return An MNFJob containing a list of NSDictionary of metadata and an error.
 */
-(MNFJob*)fetchMetaDataForKeys:(NSString*)keys completion:(nullable MNFMultipleMetadataCompletionHandlers)completion;

/**
 @abstract Updates user metadata based on the name value.
 
 @param key The key of the metadata to be updated.
 @param value The value of the metadata to be updated.
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)updateMetaDataForKey:(NSString*)key value:(NSString*)value completion:(nullable MNFErrorOnlyCompletionHandler)completion;


@end

NS_ASSUME_NONNULL_END
