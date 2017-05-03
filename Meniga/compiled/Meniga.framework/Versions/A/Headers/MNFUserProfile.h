//
//  MNFUserProfile.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 29/02/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUserProfile class represents user profile information in an object.
 
 A user profile should not be directly initialized but fetched from the server.
 */
@interface MNFUserProfile : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The server identifier for the user.
 */
@property (nonatomic,strong,readonly)    NSNumber *personId;

/**
 @abstract Whether the user has saved his profile information.
 */
@property (nonatomic,strong,readonly)    NSNumber *hasSavedProfile;

/**
 @abstract The time the user was created.
 */
@property (nonatomic,strong,readonly)    NSDate *created;

///******************************
/// @name Mutable properties
///******************************

/**
 @abstract The gender of the user.
 */
@property (nonatomic,strong)             NSNumber *gender;

/**
 @abstract The birth year of the user.
 */
@property (nonatomic,strong)             NSDate *birthYear;

/**
 @abstract The postal code of the user.
 */
@property (nonatomic,copy)             NSString *postalCode;

/**
 @abstract The number of people in the user's family.
 */
@property (nonatomic,strong)             NSNumber *numberInFamily;

/**
 @abstract The user's number of kids.
 */
@property (nonatomic,strong)             NSNumber *numberOfKids;

/**
 @abstract The user's number of cars.
 */
@property (nonatomic,strong)             NSNumber *numberOfCars;

/**
 @abstract The user's income Id.
 */
@property (nonatomic,strong)             NSNumber *incomeId;

/**
 @abstract The user's apartment's number of rooms.
 */
@property (nonatomic,strong)             NSNumber *apartmentRooms;

/**
 @abstract The user's apartment type.
 */
@property (nonatomic,strong)             NSNumber *apartmentType;

/**
 @abstract The user's apartment's size.
 */
@property (nonatomic,strong)             NSNumber *apartmentSize;

/**
 @abstract The user's apartment's size key.
 */
@property (nonatomic,strong)             NSNumber *apartmentSizeKey;

///******************************
/// @name Fetching
///******************************

/**
 @abstract Fetches a user profile for the given user.
 
 @param completion A completion block returning a user profile and an error.
 
 @return An MNFJob containing a user profile and an error.
 */
+(MNFJob*)fetchWithCompletion:(nullable MNFUserProfileCompletionHandler)completion;

///******************************
/// @name Saving
///******************************

/**
 @abstract Saves changes to the user profile to the server.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END