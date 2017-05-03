//
//  MNFSyncAuthenticationChallenge.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

@class MNFSyncAuthRequiredParameter;

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFSyncAuthenticationChallenge represents information on an authentication challenge the user receives during synchronization.
 
 A sync authentication challenge should not be directly initialized.
 */
@interface MNFSyncAuthenticationChallenge : MNFObject

/**
 @abstract Parameters the end user needs to enter.
 */
@property (nonatomic,copy,readonly) NSArray <MNFSyncAuthRequiredParameter *> *requiredParameters;

/**
 @abstract Content type of the challenge. ['0','1','2','3','4'].
 */
@property (nonatomic,strong,readonly) NSNumber *contentType;

/**
 @abstract Text challenge to be displayed to the user.
 */
@property (nonatomic,copy,readonly) NSString *textChallenge;

/**
 @abstract Binary challenge to be displayed to the user.
 */
@property (nonatomic,copy,readonly) NSString *binaryChallenge;

/**
 @abstract An error message to be displayed to the user.
 */
@property (nonatomic,copy,readonly) NSString *errorMessage;

/**
 @abstract Identifier of the end user in the current realm's namespace.
 */
@property (nonatomic,copy,readonly) NSString *userIdentifier;

/**
 @abstract Whether parameters can be saved by the system.
 */
@property (nonatomic,strong,readonly) NSNumber *canSave;

/**
 @abstract Help content to display to the user.
 */
@property (nonatomic,copy,readonly) NSString *loginHelp;

@end

NS_ASSUME_NONNULL_END