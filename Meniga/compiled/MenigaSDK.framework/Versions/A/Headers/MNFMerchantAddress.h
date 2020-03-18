//
//  MNFMerchantAddress.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 07/04/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFMerchantAddress represents all address information for a merchant.
 */
@interface MNFMerchantAddress : MNFObject

/**
 @abstract The city of the address.
 */
@property (nonatomic, copy, readonly) NSString *city;

/**
 @abstract The country of the address.
 */
@property (nonatomic, copy, readonly) NSString *country;

/**
 @abstract The country code of the address.
 */
@property (nonatomic, copy, readonly) NSString *countryCode;

/**
 @abstract The latitude of the address.
 */
@property (nonatomic, copy, readonly) NSString *latitude;

/**
 @abstract The longitude of the address.
 */
@property (nonatomic, copy, readonly) NSString *longitude;

/**
 @abstract The postal code of the address.
 */
@property (nonatomic, copy, readonly) NSString *postalCode;

/**
 @abstract The first street line of the address.
 */
@property (nonatomic, copy, readonly) NSString *streetLine1;

/**
 @abstract The second street line of the address.
 */
@property (nonatomic, copy, readonly) NSString *streetLine2;

@end

NS_ASSUME_NONNULL_END