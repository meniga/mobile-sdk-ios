//
//  MNFTransactionFilter.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 28/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNFJsonAdapterDelegate.h"
#import "MNFObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTransactionFilter class encapsulates a transaction filter json data in an object.
 
 A transaction filter should be initialized directly and used when fetching transactions using a filter.
 */
@interface MNFTransactionFilter : NSObject<MNFJsonAdapterDelegate>

/**
 @abstract The account identifiers to filter by
 */
@property(nonatomic, strong)NSArray * _Nullable accountIdentifiers;

/**
 @abstract The account IDs to filter by
 */
@property(nonatomic, strong)NSArray * _Nullable accountIds;

/**
 @abstract The amount to search from
 */
@property(nonatomic, strong)NSNumber * _Nullable amountFrom;

/**
 @abstract The amount to search to (upper limit)
 */
@property(nonatomic, strong)NSNumber * _Nullable amountTo;

/**
 @abstract Whether or not to order the returned transactions in an ascending order
 */
@property(nonatomic, strong)NSNumber * _Nullable ascendingOrder;

/**
 @abstract The Bank Id to filter by. If it's null, it will be ignored.
 */
@property(nonatomic, strong)NSString * _Nullable bankId MNF_DEPRECATED("Use bankIds instead");

/**
 A comma separated string of bank ids to filter by.
 */
@property (nonatomic,strong) NSString *_Nullable bankIds;

/**
 @abstract The category IDs to filter by
 */
@property(nonatomic, strong)NSArray * _Nullable categoryIds;

/**
 @abstract The category types to filter by. String representation.
 Expenses - An expense category
 Income - An income category
 Savings - A savings category
 Excluded - A category that is excluded from budget
 */
@property(nonatomic, strong)NSArray * _Nullable categoryTypes;

/**
 @abstract The transaction comment to filter by. If it's null, it will be ignored. But it is possible to search for empty comments.
 */
@property(nonatomic, strong)NSString * _Nullable comment;

/**
 @abstract The counterparty account identifers to filter by
 */
@property(nonatomic, strong)NSString * _Nullable counterpartyAccountIdentifiers;

/**
 @abstract The transaction currency to filter by. If it's null or empty, it will be ignored.
 */
@property(nonatomic, strong)NSString * _Nullable currency;

/**
 @abstract The transaction description to filter by. If it's null, it will be ignored. But it is possible to search for empty descriptions.
 */
@property(nonatomic, strong)NSString * _Nullable transactionDescription;

/**
 @abstract The merchant IDs to exclude
 */
@property(nonatomic, strong)NSArray * _Nullable excludeMerchantIds;

/**
 @abstract Whether or not to hide excluded transactions
 */
@property(nonatomic, strong)NSNumber * _Nullable hideExcluded;

/**
 @abstract If set, will only return transactions that have insert time before the supplied value
 */
@property(nonatomic, strong)NSDate * _Nullable insertedBefore;

/**
 @abstract The merchant IDs to filter by
 */
@property(nonatomic, strong)NSArray * _Nullable merchantIds;

/**
 @abstract The merchant texts to filter by
 */
@property(nonatomic, strong)NSArray * _Nullable merchantTexts;

/**
 @abstract Whether or not to only get flagged transactions
 */
@property(nonatomic, strong)NSNumber * _Nullable onlyFlagged;

/**
 @abstract Whether or not to only get uncategorized transactions
 */
@property(nonatomic, strong)NSNumber * _Nullable onlyUncategorized;

/**
 @abstract Whether or not to only get transactions with uncertain categorization
 */
@property(nonatomic, strong)NSNumber * _Nullable onlyUncertain;

/**
 @abstract Whether or not to only get unread transactions
 */
@property(nonatomic, strong)NSNumber * _Nullable onlyUnread;

/**
 @abstract The order of the returned transactions.
 ByDate - Order by sub-date. = 0
 ByText - Order by text description. = 1
 ByAmount - Order by amount. = 2
 ByCategory - Order by category name. = 3
 ByParsedData - Order by parsed data. = 4
 ByOriginalDate - Order by date = 5
 */
@property(nonatomic, strong)NSNumber * _Nullable orderBy;

/**
 @abstract The date to search from
 */
@property(nonatomic, strong)NSDate * _Nullable originalPeriodFrom;

/**
 @abstract The date to search to
 */
@property(nonatomic, strong)NSDate * _Nullable originalPeriodTo;

/**
 @abstract The transaction data to filter by
 */
@property(nonatomic, strong)NSArray * _Nullable parsedData;

/**
 @abstract List of keys in parsed data that should only return a match if the value is exactly the same as supplied in ParsedData
 */
@property(nonatomic, strong)NSArray * _Nullable parsedDataExactKeys;

/**
 @abstract The parsed data parameter to order by when OrderBy == ByParsedData.
 */
@property(nonatomic, strong)NSString * _Nullable parsedDataNameToOrderBy;

/**
 @abstract The sub-date to search from
 */
@property(nonatomic, strong)NSDate * _Nullable periodFrom;


/**
 @abstract The sub-date to search from
 */
@property(nonatomic, strong)NSDate * _Nullable periodTo;

/**
 @abstract A free-form text to filter by that searches through transaction description, merchant name, category name, currency, tags comments and transaction data
 */
@property(nonatomic, strong)NSString * _Nullable searchText;

/**
 @abstract The tags to filter by
 */
@property(nonatomic, strong)NSArray * _Nullable tags;

/**
 @abstract Whether or not to get uncertain categorization or flagged transactions
 */
@property(nonatomic, strong)NSNumber * _Nullable uncertainOrFlagged;

/**
 @abstract Whether or not to use absolute amount search. If true, AmountFrom = 500 and AmountTo = 1000 searches from -1000 to -500 as well as +500 to + 1000
 */
@property(nonatomic, strong)NSNumber * _Nullable useAbsoluteAmountSearch;

/**
 @abstract Whether the search performed is accent insensitive or not.
 */
@property(nonatomic, strong)NSNumber * _Nullable useAccentInsensitiveSearch;

/**
 @abstract Whether or not to search for amount in currency instead of amount.
 */
@property(nonatomic, strong)NSNumber * _Nullable useAmountInCurrencySearch;

/**
 @abstract Whether or not tags are searched with AND or OR. If true, tags are searched with AND so the transactions returned will have to contain all the Tags.
 */
@property(nonatomic, strong)NSNumber * _Nullable useAndSearchForTags;

/**
 @abstract Whether or not BankId is searched with EQUALS or LIKE. If true, exact matches are found, otherwise matches that contain the search string for BankId.
 */
@property(nonatomic, strong)NSNumber * _Nullable useEqualsSearchForBankId;

/**
 @abstract If true, filters by exact (equals) description as opposed to contains (which is the default).
 */
@property(nonatomic, strong)NSNumber * _Nullable useExactDescription;

/**
 @abstract If true, filters by exact (equals) merchant texts as opposed to contains (which is the default).
 */
@property(nonatomic, strong)NSNumber * _Nullable useExactMerchantTexts;

/**
 @abstract If set to true, parent and the parents children will be found for each merchant id provided in MerchantIds and in ExcludeMerchantIds and they included in the filter. If the merchant has no parent then its children, if any, are added
 */
@property(nonatomic, strong)NSNumber * _Nullable useParentMerchantIds;

/**
 @abstract A list of transaction ids to filter by.
 */
@property(nonatomic, strong)NSArray * _Nullable ids;

/**
 @abstract A comma seperated list of what fields should be returned.
 */
@property(nonatomic, strong)NSString * _Nullable fields;

@end

NS_ASSUME_NONNULL_END
