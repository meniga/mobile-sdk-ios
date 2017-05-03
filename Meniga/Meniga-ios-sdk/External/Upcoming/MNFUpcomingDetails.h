//
//  MNFUpcomingDetails.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@class MNFUpcomingInvoice;
@class MNFUpcomingScheduledPayment;

/**
 The MNFUpcomingDetails class contains detailed information on an upcoming transaction such as invoice and payment information.
 */
@interface MNFUpcomingDetails : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The invoice information for the upcoming transaction.
 */
@property (nonatomic,strong,readonly) MNFUpcomingInvoice *invoice;

/**
 The scheduled payment information for the upcoming transaction.
 */
@property (nonatomic,strong,readonly) MNFUpcomingScheduledPayment *scheduledPayment;

@end

NS_ASSUME_NONNULL_END