//
//  MNFTransactionPage.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 24/11/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFConstants.h"
#import "MNFObject.h"

@class MNFTransactionFilter;
@class MNFTransactionGroup;

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFTransactionPage class encapsulated transaction page json data form the server in an object.
 
 A transaction page should no be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFTransactionPage object.
 */
@interface MNFTransactionPage : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract current page
 */
@property (nonatomic, strong, readonly) NSNumber *_Nullable pageNumber;
/**
 @abstract Total number of pages
 */
@property (nonatomic, strong, readonly) NSNumber *_Nullable numberOfPages;
/**
 @abstract Transactions on current page
 */
@property (nonatomic, copy, readonly) NSArray<MNFTransaction *> *_Nullable transactions;
/**
 @abstract Total count of transactions
 */
@property (nonatomic, strong, readonly) NSNumber *_Nullable numberOfTransactions;
/**
 @abstract Total sum of the "amount" key for all transactions
 */
@property (nonatomic, strong, readonly) NSNumber *_Nullable sumOfTransactions;
/**
 @abstract number of transactions per page
 */
@property (nonatomic, strong, readonly) NSNumber *_Nullable transactionsPerPage;

///******************************
/// @name Fetching
///******************************

/**
 @abstract Fetching a transaction page using a filter.
 
 @param filter a transaction filter
 @param page The page to fetch. Defaults to zero
 @param transactionsPerPage The number of transactions on each page. Defaults to 25
 @param completion A completion block returning a transaction page and an error.
 
 @return an MNFJob containing a transaction page or an error.
 */
+ (MNFJob *)fetchWithTransactionFilter:(MNFTransactionFilter *)filter
                                  page:(nullable NSNumber *)page
                   transactionsPerPage:(nullable NSNumber *)transactionsPerPage
                            completion:(nullable MNFTransactionPageCompletionHandler)completion;

///******************************
/// @name Next page
///******************************

/**
 @abstract Appends the next page of transactions to the current transaction list. Updates pageNumber.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing either a @YES result or an error.
 */
- (MNFJob *)appendNextPageWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Replaces the transaction list with the next page of transactions. Updates pageNumber.
 
 @param completion A completion block returning an error.
 
 @return An MNFJob containing either a @YES result or an error.
 */
- (MNFJob *)nextPageWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Refreshing
///******************************

/**
 @abstract Refreshes and reorders the transaction list. Reccommended to use after a significant transaction update
 @param error An error that may occur when refreshing a transaction page.
 */
- (BOOL)refreshTransactionListWithError:(NSError **)error MNF_DEPRECATED("Please use -refreshTransactionList instead");

/**
 @abstract Refreshes and reorders the transaction list. Reccommended to use after a significant transaction update
 */
- (void)refreshTransactionList;

/**
 @abstract Refreshes the transaction list with data from the server.
 
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an error.
 */
- (MNFJob *)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Grouping
///******************************

/**
 @abstract Groups all transactions by date into transaction groups which is cached and can be accessed by using transactionsGroupedByDate method.
 */
- (void)groupByDate;

/**
 @abstract The transaction groups for all the transactions grouped by date. Make sure you have called the group by date method after any additional fetches on the transaction page.
 */
- (NSArray<MNFTransactionGroup *> *)transactionsGroupedByDate;

/**
 @abstract Groups all transactions by categoryId into transaction groups.
 */
- (void)groupByCategory;

/**
 @abstract The transactions for all the transactions grouped by category. Make sure you have called the group by category method after any additional fetches on the transaction page.
 */
- (nullable NSArray<MNFTransactionGroup *> *)transactionsGroupedByCategory;

@end

NS_ASSUME_NONNULL_END
