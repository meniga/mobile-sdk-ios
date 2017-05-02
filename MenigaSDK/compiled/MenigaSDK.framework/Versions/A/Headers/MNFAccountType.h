//
//  MNFRealmAccountType.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFAccountType class represents a realm account type.
 
 A realm account type should not be directly initialized but fetched from the server through MNFAccount.
 */
@interface MNFAccountType : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The name of the realm account type.
 */
@property (nonatomic,copy,readonly) NSString *name;

/**
 @abstract The description of the realm account type.
 */
@property (nonatomic,copy,readonly) NSString *accountDescription;

/**
 @abstract The account type of the realm account type.
 */
@property (nonatomic,strong,readonly) NSString *accountType;

@end

NS_ASSUME_NONNULL_END