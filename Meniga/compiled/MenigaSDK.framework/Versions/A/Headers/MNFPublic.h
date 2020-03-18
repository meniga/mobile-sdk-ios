//
//  MNFPublic.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/02/2017.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFCurrency.h"
#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

///******************************
/// @name Immutable properties
///******************************

/**
 The MNFPublic class represents public system settings for the user in an object.
 */
@interface MNFPublic : MNFObject

/**
 The default culture name.
 */
@property (nonatomic, copy, readonly) NSString *defaultCultureName;

/**
 The system currency.
 */
@property (nonatomic, copy, readonly) NSString *systemCurrency;

/**
 The number format.
 */
@property (nonatomic, copy, readonly) NSString *numberFormat;

/**
 The currency format.
 */
@property (nonatomic, copy, readonly) NSString *currencyFormat;

/**
 The cluster node name.
 */
@property (nonatomic, copy, readonly) NSString *clusterNodeName MNF_DEPRECATED("No longer returned with this resource.")
    ;

/**
 The currency budget round off.
 */
@property (nonatomic, strong, readonly) NSNumber *currencyRoundOff;

/**
 The currency decimal digits.
 */
@property (nonatomic, strong, readonly) NSNumber *currencyDecimalDigits;

/**
 The available currencies.
 */
@property (nonatomic, copy, readonly) NSArray<MNFCurrency *> *currencies;

/**
 The current culture.
 */
@property (nonatomic, copy, readonly) NSString *currentCulture MNF_DEPRECATED("No longer returned with this resource.");

/**
 The current currency group symbol.
 */
@property (nonatomic, copy, readonly) NSString *currencyGroupSymbol;

/**
 The current currency decimal symbol.
 */
@property (nonatomic, copy, readonly) NSString *currencyDecimalSymbol;

+ (MNFJob *)fetchPublicSettingsWithCompletion:(nullable MNFPublicCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
