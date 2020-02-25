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

/**
 The id of the parent of the account type category.
 */
@property (nonatomic, strong, readonly) NSNumber *parentId;

/**
 The name of the parent type category.
 */
@property (nonatomic, copy, readonly) NSString *parentName;

@end

NS_ASSUME_NONNULL_END
