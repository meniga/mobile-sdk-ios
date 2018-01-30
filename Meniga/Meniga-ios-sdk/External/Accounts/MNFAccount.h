//
//  MNFAccount.h
//  Meniga-ios-sdk
//
//  Created by Haukur Ísfeld on 23/10/15.
//  Copyright © 2015 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFAccountFilter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The MNFAccount class encapsulates account json data from the Meniga PFM server in an object.
 
 An account should not be directly initialized but instead should be constructed with data from the server.
 The response from the server will be automatically converted to an MNFAccount object.
 
 An account has two mutable properties which can be changed. If you change said properties you
 should remember to save the account so your changes will be saved on the server.
 If you do not save your changes they may be overwritten if you update the account with server data.
 A boolean property 'isDirty' keeps track of unsaved changes, which can then be reverted.
 */

@interface MNFAccount : MNFObject

///******************************
/// @name Immutable properties
///******************************

/**
 @abstract The bank identifier of an account.
 
 @discussion This value is an identifier for the account set by the originating bank. This identifier is used when getting account statements.
 */
@property (nonatomic,copy,readonly) NSString *accountIdentifier;

/**
 @abstract The realm identifier of an account.
 */
@property (nonatomic,copy,readonly) NSString *realmIdentifier;

/**
 @abstract The account type identifier of an account.
 
 @discussion This value is an identifier for the type (savings, checking, etc.) of an account.
 */
@property (nonatomic,strong,readonly) NSNumber *accountTypeId;

/**
 @abstract The balance of an account.
 */
@property (nonatomic,strong,readonly) NSNumber *balance;

/**
 @abstract The currency code of the account. Expressed in a ISO 4217 string.
 */
@property (nonatomic,strong,readonly) NSString *currencyCode;

/**
 @abstract The limit or overdraft of an account.
 */
@property (nonatomic,strong,readonly) NSNumber *limit;

/**
 @abstract The account class of an account.
 
 @description This value is for example used for displaying an image for an account in CSS.
 */
@property (nonatomic,copy,readonly) NSString *accountClass;

/**
 @abstract The organization name of an account.
 */
@property (nonatomic,copy,readonly) NSString *organizationName;

/**
 @abstract The organization identifier for an account.
 
 @discussion This value is a code that identifies the organization associated with this account globally, such as Swift code.
 */
@property (nonatomic,copy,readonly) NSString *organizationIdentifier;

/**
 @abstract The realm credentials identifier for an account.
 
 @discussion This value is an identifier for an online bank user that owns the account.
 */
@property (nonatomic,strong,readonly) NSNumber *realmCredentialsId;

/**
 @abstract The account authorization type for an account.
 
 @discussion This value indicates the type of account authorization during account aggregation.
 */
@property (nonatomic,copy,readonly) NSString *accountAuthorizationType;

/**
 @abstract Whether an account issues transactions to be imported manually or not.
 */
@property (nonatomic,strong,readonly) NSNumber *isImportAccount;

/**
 @abstract The last update time of an account.
 
 @discussion This value indicates when the account was last updated on the server.
 */
@property (nonatomic,strong,readonly) NSDate *lastUpdate;

/**
 @abstract The identifier of the person who owns the account.
 */
@property (nonatomic,strong,readonly) NSNumber *personId;

/**
 @abstract The email of the person who owns the account.
 */
@property (nonatomic,copy,readonly) NSString *userEmail;

/**
 @abstract The time the account was created.
 */
@property (nonatomic,strong,readonly) NSDate *createDate;

/**
 @abstract The category of the account.
 
 @discussion Indicates if the account is a checking, savings or credit account.
 */
@property (nonatomic,copy,readonly) NSString *accountCategory;

/**
 @abstract Whether the account is inactive.
 */
@property (nonatomic,strong,readonly) NSNumber *inactive;

/**
 @abstract The time when the user added this account to the PFM database.
 */
@property (nonatomic,strong,readonly) NSDate *attachedToUserDate;

/**
 @abstract Whether automatic synchronization is paused for the account
 */
@property (nonatomic,strong,readonly) NSNumber *synchronizationIsPaused;

/**
 @abstract Whether the account is used for budget calculations.
 */
@property (nonatomic,strong,readonly) NSNumber *hasInactiveBudget;

/**
 @abstract Whether transactions from the account are not used in the transaction list.
 */
@property (nonatomic,strong,readonly) NSNumber *hasInactiveTransactions;

/**
 @abstract The custom meta data of the account.
 */
@property (nonatomic,copy,readonly) NSDictionary *metadata;

///******************************
/// @name Mutable properties
///******************************

/**
 @abstract The name of the account.
 
 @discussion The name can be set by the user or the originating bank.
 */
@property (nonatomic,copy) NSString *name;

/**
 @abstract The order identifier for an account.
 
 @discussion Accounts are ordered in ascending order by this order key.
 */
@property (nonatomic,strong) NSNumber *orderId;

/**
 @abstract Whether the account should be hidden in overview.
 */
@property (nonatomic,strong) NSNumber *isHidden;

/**
 @abstract Whether the account is excluded from all calculations.
 */
@property (nonatomic,strong) NSNumber *isDisabled;

/**
 @abstract The emergency fund balance limit of the account.
 */
@property (nonatomic,strong) NSNumber *emergencyFundBalanceLimit;

///******************************
/// @name Fetching
///******************************

/**
 @abstract Fetches an object with a given identifier from the server.
 
 @param identifier The server identifier for the account.
 @param completion A completion block returns an instance of MNFAccount and an error.
 
 @return MNFJob A job containing a result, metadata and error.
 */
+(MNFJob*)fetchWithId:(NSNumber *)identifier completion:(nullable MNFAccountCompletionHandler)completion;

/**
 @abstract Fetches all accounts for the user.
 
 @param completion A completion block returns an array of MNFAccount instances and an error.
 
 @return MNFJob A job containing an array of MNFAccount instances or an error.
 */
+(MNFJob*)fetchAccountsWithFilter:(nullable MNFAccountFilter *)filter completion:(nullable MNFMultipleAccountsCompletionHandler)completion;

///******************************
/// @name Saving
///******************************

/**
 @abstract Saves changes to the account to the server.
 
 @param completion A completion block returns a result and an error.
 
 @return MNFJob A job containing a result and an error.
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Refreshing
///******************************

/**
 @abstract Refreshes the account with data from the server.
 
 @param completion A completion block returns an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Deleting
///******************************

/**
 @abstract Deletes the account from the PFM server.
 
 @param completion A completion block returns a result and an error. The result will always be nil.
 
 @return MNFJob A job containing a result or an error. The result will always be nil.
 */
-(MNFJob*)deleteAccountWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

///******************************
/// @name Account types
///******************************

/**
 @abstract Fetches a list of all available account types.
 
 @param completion A completion block returns an array of account category types and an error.
 
 @return MNFJob A job containing an array of account types or an error.
 */
+(MNFJob*)fetchAccountCategoriesWithCompletion:(nullable MNFMultipleAccountCategoriesCompletionHandler)completion;

/**
 @abstract Fetches a list of all available account authorization types.
 
 @param completion A completion block returns an array of account authorization types and an error.
 
 @return MNFJob A job containing an array of account authorization types or an error.
 */
+(MNFJob*)fetchAccountAuthorizationTypesWithCompletion:(nullable MNFMultipleAccountAuthorizationTypesCompletionHandler)completion;

/**
 @abstract Fetches a list of all realm account types.
 
 @param completion A completion block returning a list of realm account types and an error.
 
 @return An MNFJob containing a list of realm account types and an error.
 */
+(MNFJob*)fetchAccountTypesWithCompletion:(nullable MNFMultipleAccountTypesCompletionHandler)completion DEPRECATED_ATTRIBUTE;

///******************************
/// @name Metadata
///******************************

/**
 @abstract Fetches account metadata for the account.
 
 @param completion A completion block returning a list of NSDictionary of metadata and an error.
 
 @return An MNFJob containing a list of NSdictionary of metadata and an error.
 */
-(MNFJob*)fetchMetadataWithCompletion:(nullable MNFMultipleMetadataCompletionHandlers)completion;

/**
 @abstract Fetches account metadata for the account.
 
 @param completion A completion block returning a list of NSDictionary of metadata and an error.
 
 @return An MNFJob containing a list of NSdictionary of metadata and an error.
 */
-(MNFJob*)fetchMetadataForKey:(NSString*)key withCompletion:(nullable MNFMetadataValueCompletionHandler)completion;

/**
 @abstract Creates or updates metadata for the defined key.
 
 @param value The value of the metadata.
 @param aKey The key of the metadata.
 @param completion A completion block returning an error.
 
 @return MNFJob A job containing an NSNumber with a boolean true or an error.
 */
-(MNFJob*)setMetadataValue:(NSString*)value forKey:(NSString<NSCopying>*)aKey completion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Fetches account balance history entries.
 
 @param fromDate The date from which to fetch.
 @param toDate The date to which to fetch.
 @param sortBy A sort descriptor to order results from either balance date or balance. The only accepted descriptors are @"Balance" and @"BalanceDate". Any other descriptor will return an error. The default behavior is sort by balance date.
 @param ascending Whether to sort the result in ascending or descending order.
 @param completion A completion block returning a list of balance history entries and an error.
 
 @return An MNFJob containing a list of balance history entries and an error.
 */
-(MNFJob*)fetchHistoryFromDate:(NSDate*)fromDate toDate:(NSDate*)toDate sortBy:(nullable NSString*)sortBy ascending:(BOOL)ascending completion:(nullable MNFMultipleAccountHistoryCompletionHandler)completion;

//#endif

@end

NS_ASSUME_NONNULL_END
