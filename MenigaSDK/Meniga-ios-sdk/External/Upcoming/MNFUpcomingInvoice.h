//
//  MNFUpcomingInvoice.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFUpcomingInvoice class contains information on an invoice linked to an upcoming transaction.
 */
@interface MNFUpcomingInvoice : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 The identifier that uniquely identifies this entry in the external system.
 */
@property (nonatomic,copy,readonly) NSString *invoiceIdentifier;

/**
 An identifier that connects invoices to scheduled payments to transactions in the external system.
 */
@property (nonatomic,copy,readonly) NSString *bankReference;

/**
 The title or subject matter of the invoice.
 */
@property (nonatomic,copy,readonly) NSString *invoiceText;

/**
 The absolute amount of the invoice in the currency defined in 'CurrencyCode', excluding fee and VAT.
 */
@property (nonatomic,strong,readonly) NSNumber *amountInCurrency;

/**
 The absolute fee of the invoice.
 */
@property (nonatomic,strong,readonly) NSNumber *feeAmount;

/**
 The absolute VAT of the invoice.
 */
@property (nonatomic,strong,readonly) NSNumber *vatAmount;

/**
 The ISO 4217 currency code of the amounts.
 */
@property (nonatomic,copy,readonly) NSString *currencyCode;

/**
 The date when the invoice was issued.
 */
@property (nonatomic,strong,readonly) NSDate *issuedDate;

/**
 The date when the invoice is due to be paid.
 */
@property (nonatomic,strong,readonly) NSDate *dueDate;

/**
 The last date before any late fees will be applied to the invoice.
 */
@property (nonatomic,strong,readonly) NSDate *finalDueDate;

/**
 The date when this invoice was paid/booked.s
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
 Whether the invoice is account receivable or account payable.
 */
@property (nonatomic,strong,readonly) NSNumber *isReceivable;

/**
 The name of the issuer of the invoice.
 */
@property (nonatomic,copy,readonly) NSString *issuerName;

/**
 The identifier that uniquely identifies the issuer of this invoice in the external system.
 */
@property (nonatomic,copy,readonly) NSString *issuerIdentifier;

/**
 The identifier that uniquely identifies the issuer's account that this invoice should be paid from/into in the external system.
 */
@property (nonatomic,copy,readonly) NSString *issuerAccIdentifier;

/**
 The internal reference text used by the issuer.
 */
@property (nonatomic,copy,readonly) NSString *issuerReferenceText;

/**
 The name of the counterparty or institution entering into a financial contract.
 */
@property (nonatomic,copy,readonly) NSString *counterpartyName;

/**
 The counterparty from the issuer point of view. This identifier uniquely identifies the party that this invoice was issued to.
 */
@property (nonatomic,copy,readonly) NSString *counterpartyIdentifier;

/**
 The identifier that uniquely identifies the counterparty's account that this invoice should be paid from/into in the external system.
 */
@property (nonatomic,copy,readonly) NSString *counterpartyAccIdentifier;

/**
 The internal reference text used by the counterparty.
 */
@property (nonatomic,copy,readonly) NSString *counterpartyReferenceText;

@end

NS_ASSUME_NONNULL_END