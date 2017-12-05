//
//  MNFOrganization.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/05/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

#import "MNFOrganizationRealm.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFOrganization class encapsulates organization data in an object.
 
 An organization should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFOrganization object.
 */
@interface MNFOrganization : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The name of the organization
 */
@property (nonatomic,copy,readonly) NSString *name;

/**
 An alternative name of the organization.
 */
@property (nonatomic,copy,readonly) NSString *altName;

/**
 A code that identifies this organization globally, such as Swift code.
 */
@property (nonatomic,copy,readonly) NSString *organizationIdentifier;

/**
 Used to order accounts for display.
 */
@property (nonatomic,strong,readonly) NSNumber *orderIndex;

/**
 The file path for the icon.
 */
@property (nonatomic,copy,readonly) NSString *iconFileName;

/**
 The id of icon file.
 */
@property (nonatomic,strong,readonly) NSNumber *imageDataId;

/**
 The base64 encoded image data.
 */
@property (nonatomic,copy,readonly) NSString *imageData;

/**
 Realms belonging to this organization.
 */
@property (nonatomic,copy,readonly) NSArray <MNFOrganizationRealm*> *realms;

///******************************
/// @name Fetching
///******************************

/**
 Fetches a list of organizations.
 
 @param nameSearch A case-insensitive search string in organization name. If nil returns all.
 @param completion A completion block returning a list of organizations and an error.
 
 @return MNFJob A job containing an organization and an error.
 */
+ (MNFJob*)fetchOrganizationsWithNameSearch:(nullable NSString *)nameSearch completion:(nullable MNFOrganizationsCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
