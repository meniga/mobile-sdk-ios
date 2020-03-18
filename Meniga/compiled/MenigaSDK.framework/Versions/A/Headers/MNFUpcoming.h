//
//  MNFUpcoming.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 30/09/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MNFUpcomingPaymentStatus) {
    MNFUpcomingPaymentStatusOpen = 0,
    MNFUpcomingPaymentStatusOnHold,
    MNFUpcomingPaymentStatusPaid,
    MNFUpcomingPaymentStatusNone
};

@class MNFUpcomingComment;
@class MNFUpcomingDetails;
@class MNFUpcomingRecurringPattern;
@class MNFUpcomingReconcileScore;

/**
 The MNFUpcoming represents information on upcoming transactions created by the user.
 */

@interface MNFUpcoming : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 An identifier that connects invoices to scheduled payments to transactions in the external system.
 */
@property (nonatomic, copy, readonly) NSString *bankReference;

/**
 The amount of the upcoming transaction in system currency.
 */
@property (nonatomic, strong, readonly) NSNumber *amount;

/**
 The id of the actual transaction once booked.
 */
@property (nonatomic, strong, readonly) NSNumber *transactionId;

/**
 The id of the invoice this upcoming transaction is based on.
 */
@property (nonatomic, strong, readonly) NSNumber *invoiceId;

/**
 The id of the scheduled payment this upcoming transaction is based on.
 */
@property (nonatomic, strong, readonly) NSNumber *scheduledPaymentId;

/**
 A list of comments related to the upcoming transaction.
 */
@property (nonatomic, copy, readonly) NSArray<MNFUpcomingComment *> *comments;

/**
 A list of possible reconcile matches.
 */
@property (nonatomic, copy, readonly) NSArray<MNFUpcomingReconcileScore *> *reconcileScores;

/**
 Details of the upcoming transaction. Only set when explicitly requested for.
 */
@property (nonatomic, strong, readonly) MNFUpcomingDetails *details;

/**
 The recurring pattern this upcoming transaction was created from.
 */
@property (nonatomic, strong, readonly) MNFUpcomingRecurringPattern *recurringPattern;

///******************************
/// @name Mutable properties
///******************************

/**
 The title or subject of the transaction.
 */
@property (nonatomic, copy) NSString *text;

/**
 The amount for the upcoming transaction in the currency of the 'CurrencyCode'.
 */
@property (nonatomic, strong) NSNumber *amountInCurrency;

/**
 The ISO 4217 currency code of the 'AmountInCurrency'.
 */
@property (nonatomic, copy) NSString *currencyCode;

/**
 The expected payment date of the upcoming transaction.
 */
@property (nonatomic, strong) NSDate *date;

/**
 Whether the upcoming transaction is flagged by the user.
 */
@property (nonatomic, strong) NSNumber *isFlagged;

/**
 Whether the upcoming transaction is added to the watched list.
 */
@property (nonatomic, strong) NSNumber *isWatched;

/**
 The id of the account the upcoming transaction is expected to be booked from.
 */
@property (nonatomic, strong) NSNumber *accountId;

/**
 The id of the category this upcoming transaction has been categorized as.
 */
@property (nonatomic, strong) NSNumber *categoryId;

/**
 The payment status of the upcoming payment. Either 'Open','Paid' or 'OnHold'.
 */
@property (nonatomic, copy) NSString *paymentStatus;

///******************************
/// @name Fetching
///******************************

/**
 Fetches an upcoming transaction with a given identifier.
 
 @param upcomingId The identifier of the upcoming transaction.
 @param completion A completion handler returning an upcoming transaction and an error.
 
 @return MNFJob A job containing a result, metadata and an error.
 */
+ (MNFJob *)fetchUpcomingWithId:(NSNumber *)upcomingId completion:(nullable MNFUpcomingCompletionHandler)completion;

/**
 Fetches a list of upcoming transactions in the given time period.
 
 @param fromDate The starting date of the time period.
 @param toDate The end date of the time period.
 @param completion A completion block returning a list of upcoming transactions and an error.
 
 @return MNFJob A job containing a list of upcoming transactions, metadata and an error.
 */
+ (MNFJob *)fetchUpcomingFromDate:(NSDate *)fromDate
                           toDate:(NSDate *)toDate
                       completion:(nullable MNFMultipleUpcomingCompletionHandler)completion;

/**
 Fetches a list of upcoming transactions in the given time period and filtered by optional parameters.
 
 @param fromDate The starting date of the time period.
 @param toDate The end date of the time period.
 @param accountIds A comma seperated string of account ids to filter by.
 @param includeDetails Whether the result should include details on upcoming transactions.
 @param watchedOnly Whether the result should return only watched transactions.
 @param recurringPatternId The id of the recurring pattern of the upcoming transactions.
 @param paymentStatus The payment status to filter by.
 @param completion A completion block returning a list of upcoming transactions and an error.
 
 @return MNFJob A job containing a list of upcoming transactions, metadata and an error.
 */
+ (MNFJob *)fetchUpcomingFromDate:(NSDate *)fromDate
                           toDate:(NSDate *)toDate
                       accountIds:(nullable NSString *)accountIds
                   includeDetails:(BOOL)includeDetails
                      watchedOnly:(BOOL)watchedOnly
               recurringPatternId:(nullable NSNumber *)recurringPatternId
                    paymentStatus:(MNFUpcomingPaymentStatus)paymentStatus
                       completion:(nullable MNFMultipleUpcomingCompletionHandler)completion;

///******************************
/// @name Creating
///******************************

/**
 Creates new upcoming transactions with the give parameters and an optional recurring pattern.
 
 @param text The title or subject of the transaction.
 @param amountInCurrency The amount in currency of the transaction.
 @param currencyCode The ISO 4217 currency code of the transaction.
 @param date The date of the transaction.
 @param accountId The account id of the account the upcoming transaction is expected to be booked from.
 @param categoryId The category id of the transaction.
 @param isFlagged Whether the transaction is flagged.
 @param isWatched Whether the transaction will be added to a watch list.
 @param recurringPattern A recurring pattern for the transaction. This will potentially created many upcoming transactions.
 @param completion A completion block returning a list of upcoming transactions and an error.
 
 @return MNFJob A job containing a list of upcoming transactions, metadata and an error.
 */
+ (MNFJob *)createUpcomingWithText:(NSString *)text
                  amountInCurrency:(NSNumber *)amountInCurrency
                      currencyCode:(nullable NSString *)currencyCode
                              date:(NSDate *)date
                         accountId:(nullable NSNumber *)accountId
                        categoryId:(nullable NSNumber *)categoryId
                         isFlagged:(nullable NSNumber *)isFlagged
                         isWatched:(nullable NSNumber *)isWatched
                  recurringPattern:(nullable MNFUpcomingRecurringPattern *)recurringPattern
                        completion:(nullable MNFMultipleUpcomingCompletionHandler)completion;

///******************************
/// @name Deleting
///******************************

/**
 Deletes the upcoming transaction from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 
 @note Remember to deallocate objects that have been deleted on the server.
 */
- (MNFJob *)deleteUpcomingWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Saving
///******************************

/**
 Save any local changes to the upcoming transaction to the server.
 
 @param completion A completion block returning an error.
 @param allInSeries Whether the change applies to all upcoming transactions made from the same repeat pattern.
 
 @return MNFJob A job containing an error.
 
 @note Remember to revert an object if saving is unsuccessful to be in sync with the server data.
 */
- (MNFJob *)saveAllInSeries:(BOOL)allInSeries withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Comment
///******************************

/**
 Posts a comment on the upcoming transaction.
 
 @param comment The comment to post.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
- (MNFJob *)postComment:(NSString *)comment withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Accounts
///******************************

/**
 Fetches the account id for the default account all upcoming transactions are expected to be booked from unless the user states otherwise.
 
 @param completion A completion returning the default account id and an error.
 
 @return MNFJob A job containing the default account id and an error.
 */
+ (MNFJob *)fetchDefaultAccountIdWithCompletion:(nullable MNFDefaultAccountIdCompletionHandler)completion;

/**
 Sets the default account id.
 
 @param accountId The id of the account to be set as the default account.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+ (MNFJob *)setDefaultAccountId:(NSNumber *)accountId withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 Fetches all the account ids for accounts that are included in the cash flow predicted accounts' balances.
 
 @param completion A completion block returning a list of account ids and an error.
 
 @return MNFJob A job containing a list of account ids and an error.
 */
+ (MNFJob *)fetchIncludedAccountIdsWithCompletion:(nullable MNFMultipleAccountIdsCompletionHandler)completion;

/**
 Sets the account ids of the accounts to be included in the cash flow predicted accounts' balances.
 
 @param accountIds A comma seperated string of the account ids to be included.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
+ (MNFJob *)setIncludedAccountIds:(NSString *)accountIds
                   withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END