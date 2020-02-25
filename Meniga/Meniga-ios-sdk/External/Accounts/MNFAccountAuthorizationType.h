//
//  MNFAccountAuthorizationType.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFAccountAuthorizationType class represents an account authorization type.
 
 An account authorization type should not be directly initialized but fetched from the server through MNFAccount.
 */
@interface MNFAccountAuthorizationType : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The name of the account authorization type.
 */
@property (nonatomic, copy, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END