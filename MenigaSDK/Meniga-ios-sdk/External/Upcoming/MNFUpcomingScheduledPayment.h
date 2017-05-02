//
//  MNFUpcomingScheduledPayment.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUpcomingScheduledPayment class contains information on scheduled payments.
 */
@interface MNFUpcomingScheduledPayment : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The identifier htat uniquely identifies this entry in the external system.
 */
@property (nonatomic,copy,readonly) NSString *paymentIdentifier;

/**
 An identifier that connects invoices to scheduled payments to transactions in the external system.
 */
@property (nonatomic,copy,readonly) NSString *bankReference;

/**
 The title or subject matter of the scheduled payment.
 */
@property (nonatomic,copy,readonly) NSString *paymentText;

/**
 A free form text from the external system.s
 */
@property (nonatomic,copy,readonly) NSString *referenceText;

/**
 The absolute amount of the scheduled payment in the currency define in 'CurrencyCode'.
 */
@property (nonatomic,strong,readonly) NSNumber *amountInCurrency;

/**
 The ISO 4217 currency code of the 'AmountInCurrency'.
 */
@property (nonatomic,copy,readonly) NSString *currencyCode;

/**
 The date when the scheduled payment was issued/created in the external system.
 */
@property (nonatomic,strong,readonly) NSDate *issuedDate;

/**
 The date when the scheduled payment is due to be paid.
 */
@property (nonatomic,strong,readonly) NSDate *dueDate;

/**
 The date when this scheduled payment was paid/booked.
 */
@property (nonatomic,strong,readonly) NSDate *bookingDate;

/**
 The payment status of the upcoming transaction. 'Open','Paid' or 'OnHold'.
 */
@property (nonatomic,copy,readonly) NSString *paymentStatus;

/**
 Custom data parsed into key-value pairs.
 */
@property (nonatomic,copy,readonly) NSDictionary *parsedData;

/**
 Whether the scheduled payment is a collection or a payment.
 */
@property (nonatomic,strong,readonly) NSNumber *isReceivable;

/**
 The account identifier that uniquely identifies the withdrawal account in the external system that this scheduled payment should be paid from.
 */
@property (nonatomic,copy,readonly) NSString *sourceAccIdentifier;

/**
 The account identifier that uniquely identifies the destination account in the external system that the scheduled payment should be paid to.s
 */
@property (nonatomic,copy,readonly) NSString *destinationAccIdentifier;

@end

NS_ASSUME_NONNULL_END