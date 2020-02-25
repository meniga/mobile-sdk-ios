//
//  MNFRealmAccountType.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 11/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

@class MNFImportAccountConfiguration;

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
@property (nonatomic, copy, readonly) NSString *name;

/**
 @abstract The description of the realm account type.
 */
@property (nonatomic, copy, readonly) NSString *accountDescription;

/**
 The account category for this account type. 'Unknown', 'Current', 'Credit', 'Savings', 'Loan', 'Wallet', 'Manual.
 */
@property (nonatomic, copy, readonly) NSString *accountCategory;

/**
 The account class that is for example used for displaying an image for this account in CSS.
 */
@property (nonatomic, copy, readonly) NSString *accountClass;

/**
 The id of the organization associated with this account type.
 */
@property (nonatomic, strong, readonly) NSNumber *organizationId;

/**
 This will include information about supported file type extensions and parser class for import account types.
 */
@property (nonatomic, copy, readonly) MNFImportAccountConfiguration *importAccountConfiguration;

/**
 The id of the realm used to synchronize transactions.
 */
@property (nonatomic, strong, readonly) NSNumber *realmId;

/**
 Extra information about the account category, f.x. 'visa' or 'amex' for the 'Credit' account category.
 */
@property (nonatomic, copy, readonly) NSString *accountCategoryDetails;

/**
 True if cashback can be calculated for the account.
 */
@property (nonatomic, strong, readonly) NSNumber *enableCashback;

/**
 @abstract The account type of the realm account type.
 */
@property (nonatomic, strong, readonly) NSString *accountType MNF_DEPRECATED("Use account category instead");

/**
 @abstract Fetches a list of all realm account types.
 
 @param organizationId The id of an organization to get the account types for. If nil then returns all account types.
 @param completion A completion block returning a list of realm account types and an error.
 
 @return An MNFJob containing a list of realm account types and an error.
 */
+ (MNFJob *)fetchAccountTypesWithOrganizationId:(nullable NSNumber *)organizationId
                                     completion:(nullable MNFMultipleAccountTypesCompletionHandler)completion;

/**
 @abstract Fetches a realm account type with a given identifier.
 
 @param identifier The identifier of the account type.
 @param completion A completion block returning a realm account type and an error.
 
 @return An MNFJob containing a realm account type and an error.
 */
+ (MNFJob *)fetchAccountTypeWithId:(NSNumber *)identifier
                        completion:(nullable MNFAccountTypeCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
