//
//  MNFOfferFilter.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 4/27/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

@interface MNFOfferFilter : MNFObject

/**
 @abstract List of offer states to filer on. Expected values: all, activated, available, declined and expired. By default nil.
 */
@property (nonatomic, strong, readwrite, nullable) NSArray <NSString *> *offerStates;

/**
 @abstrct Retrieves specific offer ids.
 
 @warning The offerStates and expiredWithCasbackOnly will be ignored when this parameter is set. By default nil.
 */
@property (nonatomic, strong, readwrite, nullable) NSArray <NSString *> *offerIds;

/**
 @abstract Expired offers without any repayment transactions will be xcuded when this parameter is set to true. By default it is false.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *expiredWithCashbackOnly;

/**
 @abstract Wether the meta field should be skipped in the return.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *skipMeta;

/**
 @abstract The central latitude for location filtering.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *latitude;

/**
 @abstract The central logitude for location filtering.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *longitude;

/**
 @abstract The radius in km for location filtering.
 */
@property (nonatomic, strong, readwrite, nullable) NSNumber *limitLocations;

@end
