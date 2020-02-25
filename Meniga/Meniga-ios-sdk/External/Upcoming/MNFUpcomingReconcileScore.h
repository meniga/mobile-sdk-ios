//
//  MNFUpcomingReconcileScore.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUpcomingReconcileScore class contains information on how well a suggested upcoming transaction matches a real transaction.
 */
@interface MNFUpcomingReconcileScore : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The id of the upcoming transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *upcomingId;

/**
 The id of the real transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *transactionId;

/**
 The calculated confidence score from the system.
 */
@property (nonatomic, strong, readonly) NSNumber *confidenceScore;

/**
 Whether the user has confirmed the match.
 */
@property (nonatomic, strong, readonly) NSNumber *isConfirmed;

@end

NS_ASSUME_NONNULL_END