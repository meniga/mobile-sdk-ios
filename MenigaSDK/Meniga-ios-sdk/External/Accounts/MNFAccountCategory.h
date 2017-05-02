//
//  MNFNetworthType.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 31/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFAccountType class represents account types.
 
 An account type should not be initialized directly but fetched from the server through MNFAccount.
 */
@interface MNFAccountCategory : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The name of the account type.
 */
@property (nonatomic, copy, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END