//
//  MNFMerchant.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@class MNFMerchantAddress, MNFCategoryScore;

/**
 The MNFMerchant class represents all information of a merchant.
 */
@interface MNFMerchant : MNFObject

/**
 @abstract The address of the merchant represented in an MNFMerchantAddress object.
 */
@property (nonatomic, strong, readonly) MNFMerchantAddress *address;

/**
 @abstract A list of category scores for the merchant represented in MNFCategoryScores objects.
 */
@property (nonatomic, copy, readonly) NSArray<MNFCategoryScore *> *categoryScores;

/**
 @abstract A list of child merchants of this merchant.
 */
@property (nonatomic, copy, readonly) NSArray<MNFMerchant *> *childMerchants;

/**
 @abstract A list of detected categories and their scores for this merchant.
 */
@property (nonatomic, copy, readonly) NSArray<MNFCategoryScore *> *detectedCategory;

/**
 @abstract The directory link of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *directoryLink;

/**
 @abstract The email of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *email;

/**
 @abstract The unique identifier of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *merchantIdentifier;

/**
 @abstract The master identifier of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *masterIdentifier;

/**
 @abstract The merchant category identifier of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *merchantCategoryIdentifier;

/**
 @abstract The name of the identifier.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 @abstract An offers link for the merchant.
 */
@property (nonatomic, copy, readonly) NSString *offersLink;

/**
 @abstract The parent identifier of the merchant.
 */
@property (nonatomic, strong, readonly) NSNumber *parentId;

/**
 @abstract The parent merchant of this merchant.
 */
@property (nonatomic, strong, readonly) MNFMerchant *parentMerchant;

/**
 @abstract The name of the parent merchant of this merchant.
 */
@property (nonatomic, copy, readonly) NSString *parentName;

/**
 @abstract The public identifier of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *publicIdentifier;

/**
 @abstract The telephone number of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *telephone;

/**
 @abstract The web page of the merchant.
 */
@property (nonatomic, copy, readonly) NSString *webpage;

/**
 @abstract Custom attributes of the merchant.
 */
@property (nonatomic, readonly) NSDictionary *customAttributes;

/**
 @abstract Fetches a merchant with a given identifier.
 
 @param identifier The identifier of the merchant.
 @param completion A completion block returning a merchant and an error.
 
 @return An MNFJob containing a merchant and an error.
 */
+ (MNFJob *)fetchWithId:(NSNumber *)identifier completion:(nullable MNFMerchantCompletionHandler)completion;

/**
 @abstract Fetches a list of merchants with a given identifiers.
 
 @param identifiers The identifiers of the merchants. Duplicate identifiers are filtered out.
 @param completion A completion block returning a list of merchants and an error.
 
 @return An MNFJob containing a list of merchants and an error.
 */
+ (MNFJob *)fetchMerchantsWithIds:(NSArray<NSNumber *> *)identifiers
                       completion:(nullable MNFMultipleMerchantsCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
