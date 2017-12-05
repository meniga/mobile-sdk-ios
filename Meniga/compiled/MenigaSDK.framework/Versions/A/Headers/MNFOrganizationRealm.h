//
//  MNFOrganizationRealm.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 08/05/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFOrganizationRealm class encapsulates organization realm data in an object.
 
 A realm should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFOrganizationRealm object.
 */
@interface MNFOrganizationRealm : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 Description of the realm.
 */
@property (nonatomic,copy,readonly) NSString *realmDescription;

/**
 A code that identifies this realm globally.
 */
@property (nonatomic,copy,readonly) NSString *realmIdentifier;

/**
 The authorization type of this realm. 'None', 'External', 'Internal' or 'ExternalMultifactor'.
 */
@property (nonatomic,copy,readonly) NSString *authorizationType;

/**
 The id of a page in the content admin system to link to as a help page for this realm.
 */
@property (nonatomic,strong,readonly) NSNumber *contentPageId;

/**
 The URL where the external registered takes place.
 */
@property (nonatomic,copy,readonly) NSString *externalRegistrationUrl;

/**
 Whether to show this realm during signup.
 */
@property (nonatomic,strong,readonly) NSNumber *showDuringSignup;

@end

NS_ASSUME_NONNULL_END
