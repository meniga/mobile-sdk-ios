//
//  MNFSyncAuthRequiredParameter.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 20/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFSyncAuthRequiredParameter represents parameters required by the user for synchronization.
 
 A sync auth required parameter should not be directly initialized.
 */
@interface MNFSyncAuthRequiredParameter : MNFObject

/**
 @abstract The name of the parameter.
 */
@property (nonatomic,copy,readonly) NSString *name;

/**
 @abstract Friendly name of the parameter to display to the user.
 */
@property (nonatomic,copy,readonly) NSString *displayName;

/**
 @abstract Regular expression to validate the parameter value.
 */
@property (nonatomic,copy,readonly) NSString *regularExpression;

/**
 @abstract Minimum length of the parameter value.
 */
@property (nonatomic,strong,readonly) NSNumber *minLength;

/**
 @abstract Maximum length of the parameter value.
 */
@property (nonatomic,strong,readonly) NSNumber *maxLength;

/**
 @abstract Whether the parameter is a password.
 */
@property (nonatomic,strong,readonly) NSNumber *isPassword;

/**
 @abstract Whether the parameter is hidden.
 */
@property (nonatomic,strong,readonly) NSNumber *isHidden;

/**
 @abstract Whether the parameter is a drop down field.
 */
@property (nonatomic,strong,readonly) NSNumber *isDropDown;

/**
 @abstract Values that the user can select the parameter from if it is a drow down field.
 */
@property (nonatomic,copy,readonly) NSString *dropDownValues;

/**
 @abstract Parent id of the parameter.
 */
@property (nonatomic,strong,readonly) NSNumber *parentId;

/**
 @abstract Whether the parameter can be saved.
 */
@property (nonatomic,strong,readonly) NSNumber *canSave;

/**
 @abstract Whether the parameter is encrypted.
 */
@property (nonatomic,strong,readonly) NSNumber *isEncrypted;

/**
 @abstract Whether the parameter is an identity parameter.
 */
@property (nonatomic,strong,readonly) NSNumber *isIdentity;

@end

NS_ASSUME_NONNULL_END