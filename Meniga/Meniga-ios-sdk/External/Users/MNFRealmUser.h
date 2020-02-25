//
//  MNFRealmUser.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFRealmUser class represents a user's realm information.
 
 A realm user should not be directly initialized but fetched from the server.
 */
@interface MNFRealmUser : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The user identifier of the realm user.
 */
@property (nonatomic, copy, readonly) NSString *userIdentifier;

/**
 @abstract The realm id.
 */
@property (nonatomic, strong, readonly) NSNumber *realmId;

/**
 @abstract The person id.
 */
@property (nonatomic, strong, readonly) NSNumber *personId;

/**
 @abstract The user id.
 */
@property (nonatomic, strong, readonly) NSNumber *userId;

///******************************
/// @name Fetching
///******************************

/**
 @abstract Fetches a list of realm users.
 
 @param completion A completion block returning a list of realm users and an error.
 
 @return An MNFJob containing a list of realm users and an error.
 */
+ (MNFJob *)fetchRealmUsersWithCompletion:(nullable MNFMultipleRealmUsersComletionHandler)completion;

///******************************
/// @name Deleting
///******************************

/**
 @abstract Deletes a realm user.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
- (MNFJob *)deleteRealmUserWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END