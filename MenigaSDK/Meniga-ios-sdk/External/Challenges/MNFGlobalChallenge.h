//
//  MNFGlobalChallenge.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 26/01/17.
//  Copyright © 2017 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFGlobalChallenge represents a global spending challenge generated by the server.
 */
@interface MNFGlobalChallenge : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The target amount for the current global challenge.
 */
@property (nonatomic,strong,readonly) NSNumber *targetAmount;

/**
 The total spent amount in all categories for the current global challenge.
 */
@property (nonatomic,strong,readonly) NSNumber *_Nullable spentAmount;

@end

NS_ASSUME_NONNULL_END
