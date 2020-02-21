//
//  MNFOfferTransaction.h
//  Meniga-ios-sdk
//
//  Created by Mathieu Grettir Skulason on 5/12/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

@interface MNFOfferTransaction : MNFObject

/**
 @abstract The id of the offer this transaction belongs to.
 */
@property (nonatomic, strong, readonly) NSNumber *offerId;

/**
 @abstract Text of the transaction.
 */
@property (nonatomic, strong, readonly) NSString *text;

/**
 @abstract The category Id of the transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *categoryId MNF_DEPRECATED("");

/**
 @abstract The category name of the transaction.
 */
@property (nonatomic, strong, readonly) NSString *category MNF_DEPRECATED("");

/**
 @abstract The date the transaction occurred on.
 */
@property (nonatomic, strong, readonly) NSDate *date;

/**
 @abstract The amount of the transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *amount;

/**
 @abstract The amount that was redeemed on this single transaciton
 */
@property (nonatomic, strong, readonly) NSNumber *redemptionAmount;

/**
 @abstract The type of redemption.
 */
@property (nonatomic, strong, readonly) NSString *redemptionType;

/**
 @abstract The reimbursement status of the transaction for the offer.
 */
@property (nonatomic, strong, readonly) NSString *reimbursementStatus;

/**
 @abstract The reimbursement date of the transaction if it has been reibursed
 */
@property (nonatomic, strong, readonly) NSDate *reimbursementDate;

/**
 @abstract The scheduled date for the reimbursement
 */
@property (nonatomic, strong, readonly) NSDate *scheduledReimbursementDate;

/**
 The id of the redemption record.
 */
@property (nonatomic, strong, readonly) NSNumber *redemptionId;

/**
 Reimbursement account info.
 */
@property (nonatomic, copy, readonly) NSString *reimbursementAccountInfo;

@end
