//
//  MNFMerchantLocation.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 3/2/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

@interface MNFMerchantLocation : MNFObject

/**
 @abstract Latitude of the merchant.
 */
@property (nonatomic, strong, readonly) NSNumber *latitude;

/**
 @abstract Longitude of the merchant.
 */
@property (nonatomic, strong, readonly) NSNumber *longitude;

/**
 @abstract Name of the parameter.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 @abstract Address of the merchant.
 */
@property (nonatomic, strong, readonly) NSString *address;

/**
 @abstract The webpage of the merchant.
 */
@property (nonatomic, strong, readonly) NSString *webpage;

/**
 @abstract The distance from the center
 */
@property (nonatomic, strong, readonly) NSNumber *distanceKm;

@end
