//
//  MNFNetworth.h
//  Meniga-ios-sdk
//
//  Created by Aske Bendtsen on 30/03/16.
//  Copyright © 2016 Meniga. All rights reserved.
//

#import "MNFObject.h"
#import "MNFNetworthBalanceHistory.h"
#import "MNFAccountCategory.h"

NS_ASSUME_NONNULL_BEGIN
/**
 MNFNetworth represents the main networth class from which you fetch main info and lists with Networth information. Networth accounts
 */
@interface MNFNetworthAccount : MNFObject

/**
 @abstract The ID of the networth account.
 @duscission this is an accountId and is therefore also applicable in MNFAccount
 */
@property(nonatomic, strong, readonly)NSNumber *accountId;
/**
 @abstract The name of the networth account.
 @duscission Updating the account name will also affect the corresponding MNFAccount
 */
@property(nonatomic, copy)NSString *accountName;
/**
 @abstract The realmAccountTypeId of the networth account.
 @duscission This is identical to the the corresponding property in MNFAccount
 */
@property(nonatomic, strong, readonly)NSNumber *accountTypeId;
/**
 @abstract A flag indicating whether the networth account has been imported by the system.
 */
@property(nonatomic, strong, readonly)NSNumber *isImport;
/**
 @abstract A flag indicating whether the networth account has been created by the user
 @discussion Only manual accounts can be updated
 */
@property(nonatomic, strong, readonly)NSNumber *isManual;
/**
 @abstract A flag indicating if the manual account should be included or excluded from net worth.
 @discussion Only manual accounts can be updated
 */
@property(nonatomic, strong)NSNumber *isExcluded;
/**
 @abstract The net worth type.
 @discussion Should be either "Asset" or "Liability".
 */
@property(nonatomic, copy, readonly)NSString *netWorthType;
/**
 @abstract Current balance of the account.
 @discussion Must be a positive number. The service changes it according to the net worth type.
 */
@property(nonatomic, strong, readonly)NSNumber *currentBalance;
/**
 @abstract List of balance history for the networth account.
 @discussion If fetched as a summery this list will include interpolated/estimated history values.
 */
@property(nonatomic, copy, readonly)NSArray<MNFNetworthBalanceHistory*> *history;
/**
 @abstract Account type of the networth account.
 @discussion This is identical to the account type of the corresponding MNFAccount.
 */
@property(nonatomic, strong, readonly) MNFAccountType *accountType MNF_DEPRECATED("Deprecated, use accountTypeCategory instead");

/**
 The account type category.
 */
@property (nonatomic,strong,readonly) MNFAccountCategory *accountTypeCategory;

/**
 The currency code of the account.
 */
@property (nonatomic,copy,readonly) NSString *currencyCode;

/**
 The current balance in user currency.
 */
@property (nonatomic,strong,readonly) NSNumber *currentBalanceInUserCurrency;

/**
 @abstract Instantiates a new networth account object.
 @param initialBalance The initial balance of the account at the time of initialBalancedate. If nil, balance will be used.
 @param balance The current balance of the networth account.
 @param accountIdentifier  Identifier for the account set by the originating bank. This identifier is used when getting account statements.
 @param displayName The name of the networth account.
 @param networthType The networth type, either "Asset" or "Liability".
 @param initialBalanceDate the initial date for balance history on the networth account. If nil [NSDate date] will be used.
 @param completion completion executing with an error or nil.
 @return an error or a new MNFNetworthAccount object.
 @discussion This will instantiate a new networth account object on the remote with the parameters specified and with isManual equal to true.
 @note To get the object, use one of the fetch methods.
 */
+(MNFJob*)createWithInitialBalance:(nullable NSNumber*)initialBalance
                                  balance:(NSNumber*)balance
                        accountIdentifier:(nullable NSString*)accountIdentifier
                              displayName:(NSString*)displayName
                             networthType:(NSString*)networthType
                       initialBalanceDate:(nullable NSDate*)initialBalanceDate
                               completion:(nullable MNFSingleNetworthAccountsCompletionHandler)completion;


/**
 @abstract Fetches a networth account with the specified id.
 @param identifier networth account id.
 @param completion completion executing with an error or result
 @return an MNFJob with result or error
 @discussion The balance history in these Networth objects wil NOT include interpolated/estimated history values. i.e. balance history which has been estimated if there is no existing history for a specific period.
 *Note:* Unknown account types are ignored
 */
+(MNFJob*)fetchWithId:(NSNumber*)identifier completion:(nullable MNFSingleNetworthAccountsCompletionHandler)completion;

/**
 @abstract Fetches a list of networth accounts and balance history.
 @param startDate The minimum date of the balance history
 @param endDate The maximum date of the balance history
 @param useInterpolation If true, the API will return estimated values for months with no imported or manually added values.
 @param completion completion executing with an error or result
 @return An MNFJob containing an array of networth accounts or an error.
 @discussion Unknown account types are ignored
 */
+(MNFJob*)fetchWithStartDate:(NSDate*)startDate endDate:(NSDate*)endDate interPolation:(BOOL)useInterpolation completion:(nullable MNFMultipleNetworthAccountsCompletionHandler)completion MNF_DEPRECATED("Use method with skip and take instead.");

/**
 @abstract Fetches a list of networth accounts and balance history.
 @param startDate The minimum date of the balance history
 @param endDate The maximum date of the balance history
 @param useInterpolation If true, the API will return estimated values for months with no imported or manually added values.
 @param skip Number of accounts to skip. Defaults to zero.
 @param take Number of accounts to take. If null returns all.
 @param completion completion executing with an error or result
 @return An MNFJob containing an array of networth accounts or an error.
 @discussion Unknown account types are ignored
 */
+(MNFJob*)fetchWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate interPolation:(BOOL)useInterpolation skip:(nullable NSNumber*)skip take:(nullable NSNumber*)take completion:(nullable MNFMultipleNetworthAccountsCompletionHandler)completion;

/**
 @abstract Fetches a list of networth accounts and balance history.
 @param startDate The minimum date of the balance history
 @param endDate The maximum date of the balance history
 @param intervalGrouping An interval enum indicating what balance history entries should be returned Possible values are 'Dailey', 'Monthly' and 'Yearly'.
 @param skip Number of accounts to skip. Defaults to zero.
 @param take Number of accounts to take. If null returns all.
 @param completion completion executing with an error or result
 @return An MNFJob containing an array of networth accounts or an error.
 @discussion Unknown account types are ignored
 */
+(MNFJob*)fetchWithStartDate:(NSDate*)startDate endDate:(NSDate *)endDate intervalGrouping:(NSString*)intervalGrouping skip:(nullable NSNumber*)skip take:(nullable NSNumber*)take completion:(nullable MNFMultipleNetworthAccountsCompletionHandler)completion;

/**
 @abstract Fetches the date of the first entry in the networth balance history
 @param excludedAccounts Flag indicating if accounts that are excluded from net worth should be excluded.
 @param completion completion executing with an error or result
 @return Returns an MNFJob with result or error.
 */
+(MNFJob*)firstEntrydateWithExcludedAccounts:(BOOL)excludedAccounts completion:(nullable MNFSingleNetworthBalanceHistoryCompletionHandler)completion;

/**
 @abstract Fetches the available networth account types.
 @param completion completion executing with an error or result
 @return Returns an MNFJob with results or error.
 */
+(MNFJob*)fetchNetworthTypesWithCompletion:(MNFMultipleAccountTypesCompletionHandler)completion;

/**
 @abstract Refreshes the account with data from the server.
 
 @param completion A completion block returns an error.
 
 @return MNFJob A job containing an error.
 */
-(MNFJob*)refreshWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Updates the current networth account with name and visibility
 @param completion completion executing with an error or nil.
 @return Returns an MNFJob with result or error.
 @discussion Only networth accounts which are manually created can be updated
 */
-(MNFJob*)saveWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Deletes the account from networth.
 @param completion completion executing with an error or nil.
 @return MNFJob A job containing a result or an error. The task result will always be nil.
 @discussion This will remove the entity and all history for the current networth account.
 NOTE: Only manually added accounts can be deleted
 */
-(MNFJob*)deleteAccountWithCompletion:(nullable MNFErrorOnlyCompletionHandler)completion;

/**
 @abstract Adds the balance history to the networth.
 @param balanceHistory An MNFNetworthBalanceHistory object containing date and balance.
 @param completion completion executing with an error or nil.
 @return MNFJob A job containing an error.
 @discussion This will add the balance history entry to the networth
 NOTE: You can only add balance history to manually created accounts
 */
-(MNFJob*)addBalanceHistory:(MNFNetworthBalanceHistory*)balanceHistory completion:(nullable MNFErrorOnlyCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
