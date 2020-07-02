//
//  MNFTransaction.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

@class MNFTransactionFilter, MNFComment;

/**
 The MNFTransaction class encapsulates transaction json data from the server in an object.
 
 A transaction should no be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFTransaction object.
 */
@interface MNFTransaction : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The identifier of the account the transaction belongs to.
 */
@property (nonatomic, strong, readonly) NSNumber *accountId;

/**
 @abstract The account of the transaction. Parsed from the 'includes' field in the JSON.
 */
@property (nullable, nonatomic, strong) MNFAccount *account;

/**
 @abstract The amount of the transaction
 */
@property (nonatomic, strong, readonly) NSNumber *amount;

/**
 @abstract The amount in currency for the transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *amountInCurrency;

/**
 @abstract Balance of the account after this transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *balance;

@property (nonatomic, strong, readonly)
    NSNumber *accuracy DEPRECATED_MSG_ATTRIBUTE("Will not be populated in future versions");

/**
 @abstract The bank's unique identifier for the transaction.
 */
@property (nonatomic, strong, readonly) NSString *bankId;

/**
 @abstract The time when the category was last changed, or null if the category has never been changed by the user.
 */
@property (nonatomic, strong, readonly) NSDate *categoryChangedTime;

/**
 @abstract Contains Id of a rule that changed this transaction, or null if this transaction has not been modified by a rule.
 */
@property (nonatomic, strong, readonly) NSNumber *changedByRule;

/**
 @abstract The time when the transaction was last changed by a rule, or null if the category has never been changed by a rule.
 */
@property (nonatomic, strong, readonly) NSDate *changedByRuleTime;

/**
 @abstract Identifier of a counterparty account in the same realm that was transferred from/to during this transaction.
 */
@property (nonatomic, strong, readonly) NSString *counterpartyAccountIdentifier;

/**
 @abstract The currency the transaction is in.
 */
@property (nonatomic, copy, readonly) NSString *currency;

/**
 @abstract The raw data that comes with the transaction from the financial data realm.
 */
@property (nonatomic, copy, readonly) NSString *data;

/**
 @abstract Id of the data format parser used for this transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *dataFormat;

/**
 @abstract A list of detected categories.
 */
@property (nonatomic, strong, readonly) NSArray *detectedCategories;

/**
 @abstract Whether the user has cleared category uncertainty.
 */
@property (nonatomic, strong, readonly) NSNumber *hasUserClearedCategoryUncertainty;

/**
 @abstract The due date when the user needs to pay for this transaction, e.g. when the credit card bill has to be paid for credit card transactions.
 */
@property (nonatomic, strong, readonly) NSDate *dueDate;

/**
 @abstract The insert time of the transaction into the Meniga system.
 */
@property (nonatomic, strong, readonly) NSDate *insertTime;

/**
 @abstract Whether or not the transaction has been flagged.
 */
@property (nonatomic, strong, readonly) NSNumber *isFlagged;

/**
 @abstract Whether the transaction is associated with a merchant.
 */
@property (nonatomic, strong, readonly) NSNumber *isMerchant;

/**
 @abstract The merchant of the transaction. Parsed from the 'includes' field in the JSON.
 */
@property (nullable, nonatomic, strong) MNFMerchant *merchant;

/**
 @abstract Whether the transaction is an account transfer to own account.
 */
@property (nonatomic, strong, readonly) NSNumber *isOwnAccountTransfer;

/**
 @abstract Whether the transaction is the result of a split. False if the transaction is the parent of a split. Nil if the transaction has never been split.
 */
@property (nonatomic, strong, readonly) NSNumber *isSplitChild;

/**
 @abstract Whether the transaction is uncleared.
 */
@property (nonatomic, strong, readonly) NSNumber *isUncleared;

/**
 @abstract Time when the transaction was last modified.
 */
@property (nonatomic, strong, readonly) NSDate *lastModifiedTime;

/**
 @abstract The merchant category code mapping used when detecting categories.
 */
@property (nonatomic, strong, readonly) NSNumber *mcc;

/**
 @abstract Id of a merchant if the transaction was linked to a merchant.
 */
@property (nonatomic, strong, readonly) NSNumber *merchantId;

/**
 @abstract Metadatas for the transaction.
 */
@property (nonatomic, copy, readonly) NSArray *metaData;

/**
 @abstract The original amount of the transaction. Sum of split transactions result in the original amount.
 */
@property (nonatomic, strong, readonly) NSNumber *originalAmount;

/**
 @abstract The original date if the transaction date is different.
 */
@property (nonatomic, strong, readonly) NSDate *originalDate;

/**
 @abstract The original text if the transaction text is different.
 */
@property (nonatomic, copy, readonly) NSString *originalText;

/**
 @abstract The Id of the parent transaction. Nil if transaction is not a split child.
 */
@property (nonatomic, copy, readonly) NSString *parentIdentifier;

/**
 @abstract Extra fields for this transaction having field names as keys.
 
 @discussion The server supports parsed data both as a list of "key-value" pairs like '@[@{@"key":@"testKey",@"value":@"testValue"}] and regular hashmap like '@{@"testKey":@"testValue"}. The sdk will transform list based objects to regular json objects.
 */
@property (nonatomic, copy, readonly) NSDictionary *parsedData;

/**
 @abstract The transaction timestamp.
 */
@property (nonatomic, strong, readonly) NSDate *timestamp;

/**
 @abstract Holds etra custom data that is not parsed or read via the transaction data format parser.
 */
@property (nonatomic, copy, readonly) NSString *userData;

/**
 The original amount of this transaction in account currency.
 */
@property (nonatomic, strong, readonly) NSNumber *bookedAmount;

/**
 The split ratio of the transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *splitRatio;

/**
 The country code of the transaction.
 */
@property (nonatomic, strong, readonly) NSString *countryCode;

///******************************
/// @name Mutable properties
///******************************

/**
 @abstract The Id of the category of the transaction.
 */
@property (nonatomic, strong) NSNumber *categoryId;

/**
 @abstract The comment in the transaction.
 */
@property (nonatomic, copy) NSArray<MNFComment *> *comments;

/**
 @abstract The date of the transaction.
 */
@property (nonatomic, strong) NSDate *date;

/**
 @abstract Whether or not the transaction has uncertain categorization.
 */
@property (nonatomic, strong) NSNumber *hasUncertainCategorization;

/**
 @abstract The tags in the transaction.
 */
@property (nonatomic, copy) NSArray *tags;

/**
 @abstract The text in the transaction.
 */
@property (nonatomic, copy) NSString *text;

/**
 @abstract Whether the transaction has been read.
 */
@property (nonatomic, strong) NSNumber *isRead;

///******************************
/// @name Fetching
///******************************

/**
 @abstract Fetches a transaction with a given identifier.
 
 @param identifier The identifier of the transaction being fetched.
 @param completion A completion block returning an MNFTransaction instance and an NSError.
 
 @return An MNFJob containing an MNFTransaction and an error.
 */
+ (MNFJob *)fetchWithId:(NSNumber *)identifier completion:(nullable MNFTransactionCompletionHandler)completion;

/**
 @abstract Fetches all split transactions relating to the transaction.
 
 @discussion If the transaction is a parent the list will return the transaction and all it's split children. If it is a child the list will return the parent transaction, the child itself and any other children of the parent.
 
 @param completion A completion block returning a list of transactions and an error.
 
 @return An MNFJob containing a list of transactions and an error.
 */
- (MNFJob *)fetchSplitWithCompletion:(nullable MNFMultipleTransactionsCompletionHandler)completion;

/**
@abstract Fetches all transactions with applied filter.
 
@param filter MNFTransactionFilter object.

@param completion A completion block returning a list of transactions and an error.

@return An MNFJob containing a list of transactions and an error.
*/

+ (MNFJob *)fetchWithTransactionFilter:(MNFTransactionFilter *)filter
                            completion:(MNFMultipleTransactionsCompletionHandler)completion;

///************************************
/// @name Creating
///************************************

/**
 @abstract Creates a new transaction on the server.
 
 @discussion User created transactions are defined as wallet transactions. They will always have accountId = 5.
 
 @param date The date of the transaction.
 @param text The text of the transaction.
 @param amount The amount of the transaction.
 @param categoryId The categoryId of the transaction.
 @param setAsRead Whether the transaction should be set as read or not.
 @param completion A comletion block returning the transaction created and an error.
 
 @return An MNFJob containing the transaction created and an error.
 */
+ (MNFJob *)createTransactionWithDate:(NSDate *)date
                                 text:(NSString *)text
                               amount:(NSNumber *)amount
                           categoryId:(NSNumber *)categoryId
                            setAsRead:(NSNumber *)setAsRead
                           completion:(nullable MNFTransactionCompletionHandler)completion;

///************************************
/// @name Deleting
///************************************

/**
 @abstract Deletes the transaction from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 
 @warning Remember to deallocate objects that have been deleted from the server.
 */
- (MNFJob *)deleteTransactionWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Deletes comment from transaction and removes it from the comments array.
 
 @param commentIndex iIndex of the comment in the transaction comment array.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 
 @warning Remember to deallocate objects that have been deleted from the server.
 */
- (MNFJob *)deleteCommentAtIndex:(NSInteger)commentIndex
                  withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Deletes a list of transactions.
 
 @param transactions The transactions to be deleted.
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 
 @warning Remember to deallocate objects that have been deleted from the server.
 @warning The list of transactions must not be empty.
 */
+ (MNFJob *)deleteTransactions:(NSArray<MNFTransaction *> *)transactions
                withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Saving
///******************************

/**
 @abstract Saves changes to the transaction to the server.
 
 @param completion A completion block returning a result and an error.
 
 @return MNFJob A job containing a result and an error.
 */
- (MNFJob *)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Refreshing
///******************************

/**
 @abstract Refreshes the transaction with data from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
- (MNFJob *)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///************************************
/// @name Split
///************************************

/**
 @abstract Splits the transaction by a given amount. This creates a new transaction that is a split child of the transaction.
 
 @param amount The amount to split by.
 @param categoryId The category Id of the new transaction.
 @param text The text in the new transaction.
 @param flagged Whether the new transaction is flagged.
 @param completion A completion block returning a transaction and an error.
 
 @return MNFJob A job containing an MNFTransaction and an error.
 */
- (MNFJob *)splitTransactionWithAmount:(nullable NSNumber *)amount
                            categoryId:(nullable NSNumber *)categoryId
                                  text:(nullable NSString *)text
                             isFlagged:(BOOL)flagged
                            completion:(nullable MNFTransactionCompletionHandler)completion;

/**
 @abstract Updates transaction splits. This deletes existing split transactions and creates new transactions that are split children of the transaction.
 
 @param amounts The amounts to split by.
 @param categoryIds The category Ids of the new transactions.
 @param texts The texts in the new transactions.
 @param flagged Whether the new transaction is flagged.
 @param completion A completion block returning a list of transactions and an error.
 
 @warning Make sure the number of items in the arrays provided are equal.
 
 @return MNFJob A job containing an list of transactions and an error.
 */
- (MNFJob *)updateSplitTransactionWithAmount:(NSArray<NSNumber *> *)amounts
                                  categoryId:(NSArray<NSNumber *> *)categoryIds
                                        text:(NSArray<NSString *> *)texts
                                   isFlagged:(NSArray<NSNumber *> *)flagged
                                  completion:(nullable MNFTransactionCompletionHandler)completion;

///************************************
/// @name Comment
///************************************

/**
 @abstract Posts a comment to the transaction. If the comment contains any tags (words starting with '#') they are automatically created and associated with the transaction
 if they do not already exist.
 
 @param comment The comment to post.
 @param completion A completion block returning an NSError.
 
 @return An MNFJob containing an NSError.
 */
- (MNFJob *)postComment:(NSString *)comment withCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///************************************
/// @name Recategorize
///************************************

/**
 @abstract Recategorizes transactions with matching texts.
 
 @param texts The texts matching the transactions to recategorize.
 @param unreadOnly Whether only unread transactions should be recategorized.
 @param useSubText Whether subtext should be used to match transactions to texts.
 @param markAsRead Whether recategorized transactions should be marked as read.
 @param categoryId The categoryId to recategorize to. If not set the matching transactions will be recategorized according to existing categorization rules.
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
+ (MNFJob *)recategorizeWithTexts:(NSArray<NSString *> *)texts
                       unreadOnly:(BOOL)unreadOnly
                       useSubText:(BOOL)useSubText
                       markAsRead:(BOOL)markAsRead
                       categoryId:(nullable NSNumber *)categoryId
                       completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Updates a list of transactions with the specified parameters. The fields of the transactions passed in this method will be updated.
 
 @param amount The amount to update to. If null, it will not be updated. Will only affect user created transactions.
 @param categoryId The categoryId to update to. If null, it will not be updated.
 @param uncertainCategorization The uncertainCategorization to update to.
 @param useSubText True if automatic categorization should be matched against subtext otherwise it will by default be matched against text
 @param text The text to update to. If null, it will not be updated.
 @param date The date to update to. If null, it will not be updated.
 @param isRead The isRead status to update to.
 @param isFlagged The flagged state to update to.
 @param userData The userData to update to. If null, it will not be updated.
 @param completion A completion block returning an error.
 
 @return An MNFJob containing an error.
 */
+ (MNFJob *)updateTransactions:(NSArray<MNFTransaction *> *)transactions
                      withAmount:(nullable NSNumber *)amount
                      categoryId:(nullable NSNumber *)categoryId
         uncertainCategorization:(BOOL)uncertainCategorization
    useSubtextInRecategorization:(BOOL)useSubText
                            text:(nullable NSString *)text
                            date:(nullable NSDate *)date
                          isRead:(BOOL)isRead
                       isFlagged:(BOOL)isFlagged
                        userData:(nullable NSString *)userData
                      completion:(MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
