//
//  MNFCurrency.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/02/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFCurrency class represents currency information in an object.
 */
@interface MNFCurrency : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The currency code in ISO 4217.
 */
@property (nonatomic, copy, readonly) NSString *code;

/**
 Whether the currency is the default system currency.
 */
@property (nonatomic, strong, readonly) NSNumber *isDefault;

/**
 The currency name.
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 The currency number format.
 */
@property (nonatomic, copy, readonly) NSString *format;

/**
 The currency display format.
 */
@property (nonatomic, copy, readonly) NSString *currencyFormat;

/**
 The round off of the amount in currency.
 */
@property (nonatomic, strong, readonly) NSNumber *roundOff;

/**
 Whether the currency is applicable as a user currency.
 */
@property (nonatomic, strong, readonly) NSNumber *isUserCurrency;

@end

NS_ASSUME_NONNULL_END
